import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:rc_china_freshplan_app/common/router/app_router.dart';
import 'package:rc_china_freshplan_app/common/util/event_bus.dart';
import 'package:rc_china_freshplan_app/common/util/pet-util.dart';
import 'package:rc_china_freshplan_app/common/util/utils.dart';
import 'package:rc_china_freshplan_app/data/pet.dart';
import 'package:rc_china_freshplan_app/pages/breedPicker/view.dart';

class PetController extends GetxController {
  var name = "".obs;
  var gender = "".obs;
  var type = "".obs;
  var breedCode = "".obs;
  var breedName = "".obs;
  var image = "".obs;
  var birthday = "".obs;
  var recentWeight = 0.0.obs;
  var recentPosture = "".obs;
  var targetWeight = 0.0.obs;
  var recentHealth = Rx<List<String>>([]);
  dynamic isSterilized = ''.obs;

  var pet = PetUtil.getPet((Get.arguments ?? '').toString());

  var nameController = TextEditingController();

  void initData(Pet pet) {
    name.value = pet.name!;
    gender.value = pet.gender!;
    type.value = pet.type!;
    breedCode.value = pet.breedCode!;
    breedName.value = pet.breedName!;
    image.value = pet.image ?? '';
    birthday.value = pet.birthday!;
    recentWeight.value = pet.recentWeight!;
    recentPosture.value = pet.recentPosture!;
    targetWeight.value = pet.targetWeight!;
    recentHealth.value = pet.recentHealth!;

    nameController.text = pet.name ?? '';
  }

  @override
  void onReady() {
    EventBus().addListener('pet-avatar-update', (arg) {
      image.value = arg;
    });
    EventBus().addListener('pet-recent-weight-update', (arg) {
      recentWeight.value = arg;
    });
    EventBus().addListener('pet-target-weight-update', (arg) {
      targetWeight.value = arg;
    });
    EventBus().addListener('pet-birthday-update', (arg) {
      birthday.value = arg;
    });
    super.onReady();
  }

  @override
  void onInit() {
    initData(pet);
    super.onInit();

    nameController.addListener(() {
      name.value = nameController.text;
    });
  }

  @override
  void onClose() {
    super.onClose();
    name.value = "";
    gender.value = "";
    type.value = "";
    breedCode.value = "";
    breedName.value = "";
    image.value = "";
    birthday.value = "";
    recentWeight.value = 0.0;
    targetWeight.value = 0.0;
    recentPosture.value = "";
    recentHealth.value = [];
    nameController.clear();
  }

  void changeName(String text) {
    name.value = text;
  }

  void changeGender(String sex) {
    gender.value = sex;
  }

  void changeBreed(String name, String code) {
    breedName.value = name;
    breedCode.value = code;
  }

  void changeRencentPosture(String posture) {
    recentPosture.value = posture;
  }

  void addRencentHealth(String health) {
    if (health == 'NONE') {
      recentHealth.value = ['NONE'];
    } else if (recentHealth.value.contains(health)) {
      recentHealth.update((val) {
        val?.remove("NONE");
        val?.remove(health);
      });
    } else {
      recentHealth.update((val) {
        val?.remove("NONE");
        val?.add(health);
      });
    }
  }

  void selectBreed() {
    Get.to(() => BreedListPickerPage(), fullscreenDialog: true, arguments: {
      'petType': type.value,
      "callback": (name, code) {
        breedName.value = name;
        breedCode.value = code;
      }
    });
  }

  void changeIsSterilized(value) {
    isSterilized = value;
  }

  void handlePressSave() async {
    var updateFlag = await PetUtil.updatePet(Pet(
      id: pet.id,
      name: name.value,
      image: image.value,
      type: type.value,
      gender: gender.value,
      isSterilized: false,
      birthday: birthday.value,
      breedCode: breedCode.value,
      breedName: breedName.value,
      targetWeight: targetWeight.value,
      recentWeight: recentWeight.value,
      recentHealth:
          List<String>.from(recentHealth.value.map((e) => e.toString())),
      recentPosture: recentPosture.value,
    ));
    if (updateFlag) {
      Get.toNamed(AppRoutes.petList);
    }
  }

  void handleDelete(context) {
    if (pet.subscriptionNo != null && pet.subscriptionNo!.isNotEmpty) {
      EasyLoading.showToast('定制计划中，暂无法删除');
    } else {
      showTipAlertDialog(context, '您确定要删除这个宠物吗？', () async {
        var deleteFlag = await PetUtil.removePet(pet);
        if (deleteFlag) {
          Get.toNamed(AppRoutes.petList);
        }
      });
    }
  }
}
