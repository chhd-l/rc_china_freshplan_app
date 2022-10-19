import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:rc_china_freshplan_app/common/router/app_router.dart';
import 'package:rc_china_freshplan_app/common/util/event_bus.dart';
import 'package:rc_china_freshplan_app/common/util/pet-util.dart';
import 'package:rc_china_freshplan_app/common/values/colors.dart';
import 'package:rc_china_freshplan_app/common/widgets/factor.dart';
import 'package:rc_china_freshplan_app/data/pet.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rc_china_freshplan_app/common/util/http.dart';
import 'package:dio/src/multipart_file.dart' as DIOMUL;
import 'package:dio/src/form_data.dart' as DIOFORM;
import 'package:rc_china_freshplan_app/common/values/api_path.dart';
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

  int weight1 = 0;
  int weight2 = 0;

  var nameController = TextEditingController();
  var recentWeightController = TextEditingController();
  var targetWeightController = TextEditingController();

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
    recentWeightController.text = pet.recentWeight.toString();
    targetWeightController.text = pet.targetWeight.toString();
  }

  @override
  void onReady() {
    EventBus().addListener('pet-avatar-update', (arg) {
      image.value = arg;
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

    recentWeightController.addListener(() {
      recentWeight.value =
          double.tryParse(recentWeightController.text.toString()) ?? 0.0;
    });

    targetWeightController.addListener(() {
      targetWeight.value =
          double.tryParse(targetWeightController.text.toString()) ?? 0.0;
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
    recentWeightController.clear();
    targetWeightController.clear();
  }

  void changeName(String text) {
    name.value = text;
  }

  void changeBirthDay(DateTime d) {
    birthday.value = DateFormat('yyyy-MM-dd').format(d);
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

  void changeRecentWeight(String text) {
    double? v = double.tryParse(text);
    recentWeight.value = v ?? 0.0;
  }

  void changeTargetWeight(String text) {
    double? v = double.tryParse(text);
    targetWeight.value = v ?? 0.0;
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

  void selectWeight(context, type) {
    Get.bottomSheet(
        Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
            height: 350,
            color: Colors.white,
            alignment: Alignment.center,
            child: SafeArea(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "选择爱宠近期体重(公斤)",
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 17,
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Row(children: [
                        Expanded(
                            child: _cupertinoCountPicker(71, (i) {
                          weight1 = i;
                        })),
                        Expanded(
                            child: _cupertinoCountPicker(10, (i) {
                          weight2 = i;
                        })),
                      ]),
                      const Text(
                        ".",
                        style: TextStyle(
                          color: AppColors.primaryText,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                )),
                titleButton("确定", () {
                  if (type == 'now') {
                    recentWeight.value = double.parse(
                        '${weight1.toString()}.${weight2.toString()}');
                  }
                  if (type == 'target') {
                    targetWeight.value = double.parse(
                        '${weight1.toString()}.${weight2.toString()}');
                  }
                  Get.back();
                }, isCircle: true)
              ],
            ))),
        persistent: false);
  }

  Widget _cupertinoCountPicker(int count, Function(int)? callback) {
    return CupertinoPicker(
      selectionOverlay: _selectionOverlay(),
      magnification: 1.22,
      squeeze: 1.2,
      useMagnifier: true,
      itemExtent: 32.0,
      onSelectedItemChanged: callback,
      children: List<Widget>.generate(count, (int index) {
        return Center(
          child: Text((index).toString()),
        );
      }),
    );
  }

  _selectionOverlay() {
    return Padding(
      padding: EdgeInsets.zero,
      child: Column(
        children: const [
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          Spacer(),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
        ],
      ),
    );
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
      showCupertinoDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: const Text(''),
              content: Column(
                children: [
                  Image.asset('assets/images/dialog-tip-icon.png'),
                  const SizedBox(height: 24),
                  Text('您确定要删除这个宠物吗？',
                      style: textSyle700(color: AppColors.text333))
                ],
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleButton('确定', () async {
                        Get.back();
                        var deleteFlag = await PetUtil.removePet(pet);
                        if (deleteFlag) {
                          Get.toNamed(AppRoutes.petList);
                        }
                      },
                          width: 96,
                          height: 30,
                          isCircle: true,
                          bgColor: const Color.fromRGBO(200, 227, 153, 1),
                          fontSize: 12),
                      titleButton('我在想想', () {
                        Get.back();
                      },
                          width: 112,
                          height: 30,
                          isCircle: true,
                          fontSize: 12),
                    ],
                  ),
                )
              ],
              insetAnimationDuration: const Duration(seconds: 2),
            );
          });
    }
  }
}
