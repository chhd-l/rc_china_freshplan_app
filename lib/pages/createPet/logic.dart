import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:intl/intl.dart';
import 'package:rc_china_freshplan_app/common/router/app_router.dart';
import 'package:rc_china_freshplan_app/common/util/event_bus.dart';
import 'package:rc_china_freshplan_app/common/util/http.dart';
import 'package:rc_china_freshplan_app/common/util/pet-util.dart';
import 'package:rc_china_freshplan_app/common/values/api_path.dart';
import 'package:rc_china_freshplan_app/common/values/values.dart';
import 'package:rc_china_freshplan_app/common/widgets/factor.dart';
import 'package:rc_china_freshplan_app/data/pet.dart';
import 'package:rc_china_freshplan_app/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:rc_china_freshplan_app/pages/breedPicker/view.dart';

import 'state.dart';

class CreatePetLogic extends GetxController {
  final state = CreatePetState();

  final global = Get.put(GlobalConfigService());

  TextEditingController petNameController = TextEditingController();

  FocusNode petNameFocusNode = FocusNode();

  final List healthList = [
    {'name': '对食物很挑剔', 'value': 'PICKY_EATER'},
    {'name': '食物过敏或胃敏感', 'value': 'FOOD_ALLERGIES_OR_STOMACH_SENSITIVITIES'},
    {'name': '无光泽或片状被毛', 'value': 'DULL_OR_FLAKY_FUR'},
    {'name': '关节炎或关节痛', 'value': 'ARTHRITIS_OR_JOINT_PAIN'},
    {'name': '以上都没有', 'value': 'NONE'},
  ];

  @override
  void onReady() {
    EventBus().addListener('pet-avatar-update', (arg) {
      state.avatar.value = arg;
    });
    EventBus().addListener('pet-recent-weight-update', (arg) {
      state.recentWeight.value = arg;
    });
    EventBus().addListener('pet-target-weight-update', (arg) {
      state.targetWeight.value = arg;
    });
    EventBus().addListener('pet-birthday-update', (arg) {
      state.birthday.value = arg;
    });
    super.onReady();
  }

  @override
  void onInit() {
    petNameController.addListener(() {
      state.name.value = petNameController.text;
    });
    super.onInit();
  }

  isCanNext(showTip) {
    switch (state.currentStep.value) {
      case 2:
        if (state.name.value == '' && showTip) {
          EasyLoading.showInfo('请填写宠物昵称');
        }
        if (state.gender.value == '' && showTip) {
          EasyLoading.showInfo('请选择宠物性别');
        }
        return state.name.value != '' && state.gender.value != '';
      case 3:
        if (state.breedName.value == '' && showTip) {
          EasyLoading.showInfo('请选择宠物品种');
        }
        return state.breedName.value != '' && state.breedCode.value != '';
      case 4:
        if (state.birthday.value == '' && showTip) {
          EasyLoading.showInfo('请选择宠物生日');
        }
        return state.birthday.value != '';
      case 5:
        if (state.isSterilized == '' && showTip) {
          EasyLoading.showInfo('请选择宠物绝育状态');
        }
        return state.isSterilized != '';
      case 6:
        if (state.recentWeight.value == 0.0 && showTip) {
          EasyLoading.showInfo('请选择宠物近期体重');
        }
        if (state.recentPosture.value == '' && showTip) {
          EasyLoading.showInfo('请选择宠物近期状态');
        }
        if (state.targetWeight.value == 0.0 && showTip) {
          EasyLoading.showInfo('请选择宠物近期成年目标体重');
        }
        return state.recentWeight.value != 0.0 &&
            state.targetWeight.value != 0.0 &&
            state.recentPosture.value != '';
      case 7:
        if (state.recentHealth.value.isEmpty && showTip) {
          EasyLoading.showInfo('请选择健康状况');
        }
        return state.recentHealth.value.isNotEmpty;
    }
    return true;
  }

  void recommendedRecipes() async {
    Pet pet = Pet(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: state.name.value,
      gender: state.gender.value,
      type: state.type.value,
      breedCode: state.breedCode.value,
      breedName: state.breedName.value,
      image: state.avatar.value,
      isSterilized: false,
      birthday: state.birthday.value,
      recentWeight: state.recentWeight.value,
      recentPosture: state.recentPosture.value,
      targetWeight: state.targetWeight.value,
      recentHealth: state.recentHealth.value,
    );
    print(pet.toJson());
    var createFlag = await PetUtil.addPet(pet);
    if (createFlag != false) {
      global.checkoutPet.value = pet;
      Get.toNamed(AppRoutes.recommendRecipes);
    }
  }

  void changeType(value) {
    state.type.value = value;
    state.breedList.value =
        value == 'DOG' ? global.dogBreedList : global.catBreedList;
    state.currentStep.value += 1;
  }

  void changeGender(value) {
    state.gender.value = value;
    if (state.name.value != '') {
      state.currentStep.value += 1;
    }
  }

  void changeIsSterilized(value) {
    state.isSterilized = value;
    state.currentStep.value += 1;
  }

  void selectNormalBreed(breed) {
    state.breedName.value = breed["name"];
    state.breedCode.value = breed["code"];
    state.currentStep.value += 1;
  }

  void selectBreed() {
    Get.to(() => BreedListPickerPage(), fullscreenDialog: true, arguments: {
      'petType': state.type.value,
      "callback": (name, code) {
        state.breedName.value = name;
        state.breedCode.value = code;
      }
    });
  }

  void changeRecentHealth(int index) {
    final health = healthList[index]["value"];
    if (health == 'NONE') {
      state.recentHealth.value = ['NONE'];
    } else if (state.recentHealth.value.contains(health)) {
      state.recentHealth.update((val) {
        val?.remove("NONE");
        val?.remove(health);
      });
    } else {
      state.recentHealth.update((val) {
        val?.remove("NONE");
        val?.add(health);
      });
    }
  }
}
