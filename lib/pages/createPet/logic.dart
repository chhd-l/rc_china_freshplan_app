import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/src/multipart_file.dart' as DIOMUL;
import 'package:dio/src/form_data.dart' as DIOFORM;
import 'package:intl/intl.dart';
import 'package:rc_china_freshplan_app/common/router/app_router.dart';
import 'package:rc_china_freshplan_app/common/util/http.dart';
import 'package:rc_china_freshplan_app/common/util/pet-util.dart';
import 'package:rc_china_freshplan_app/common/values/api_path.dart';
import 'package:rc_china_freshplan_app/data/pet.dart';
import 'package:rc_china_freshplan_app/global.dart';
import 'package:flutter/cupertino.dart';

import 'state.dart';

class CreatePetLogic extends GetxController {
  final state = CreatePetState();

  final global = Get.put(GlobalConfigService());

  TextEditingController petNameController = TextEditingController();
  TextEditingController recentWeightController = TextEditingController();
  TextEditingController targetWeightController = TextEditingController();

  final List healthList = [
    {'name': '对食物很挑剔', 'value': 'PICKY_EATER'},
    {'name': '食物过敏或胃敏感', 'value': 'FOOD_ALLERGIES_OR_STOMACH_SENSITIVITIES'},
    {'name': '无光泽或片状被毛', 'value': 'DULL_OR_FLAKY_FUR'},
    {'name': '关节炎或关节痛', 'value': 'ARTHRITIS_OR_JOINT_PAIN'},
    {'name': '以上都没有', 'value': 'NONE'},
  ];

  @override
  void onInit() {
    super.onInit();

    recentWeightController.text = '0.0';
    targetWeightController.text = '0.0';

    petNameController.addListener(() {
      state.name.value = petNameController.text;
    });

    recentWeightController.addListener(() {
      state.recentWeight.value =
          double.parse(recentWeightController.text.toString());
    });

    targetWeightController.addListener(() {
      state.targetWeight.value =
          double.parse(targetWeightController.text.toString());
    });
  }

  isCanNext() {
    return state.name.value != '' &&
        state.type.value != '' &&
        state.breedName.value != '' &&
        state.birthday.value != '';
  }

  tapHeadIcon() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
        imageQuality: 80, maxWidth: 540, source: ImageSource.gallery);
    if (pickedFile != null) {
      _upLoadImage(pickedFile);
    }
  }

  _upLoadImage(XFile image) async {
    String path = image.path;
    var name = path.substring(path.lastIndexOf("/") + 1, path.length);
    DIOFORM.FormData formdata = DIOFORM.FormData.fromMap(
        {"file": await DIOMUL.MultipartFile.fromFile(path, filename: name)});

    EasyLoading.show(status: 'loading...');
    HttpUtil()
        .post(upload, params: formdata)
        .onError((ErrorEntity error, stackTrace) {
      EasyLoading.showError(error.message!);
    }).then((value) {
      EasyLoading.dismiss();
      if (value == null) return;
      state.avatar.value = json.decode(value.toString())["url"];
    });
  }

  void recommendedRecipes() async {
    Get.put(GlobalConfigService()).petName.value = state.name.value;
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
  }

  void selectBirthday() {
    state.birthday.value = state.birthday.value != ''
        ? state.birthday.value
        : DateFormat("yyyy-MM-dd").format(DateTime.now()).toString();
    Get.bottomSheet(Container(
      height: 200,
      color: Colors.white,
      alignment: Alignment.center,
      child: CupertinoDatePicker(
        onDateTimeChanged: (dateTime) {
          state.birthday.value =
              DateFormat("yyyy-MM-dd").format(dateTime).toString();
        },
        initialDateTime: DateTime.now(),
        minuteInterval: 1,
        mode: CupertinoDatePickerMode.date,
      ),
    ));
  }

  void selectBreed() {
    state.breedName.value = state.breedName.value != ''
        ? state.breedName.value
        : state.breedList[0]['name'];
    state.breedCode.value = state.breedCode.value != ''
        ? state.breedCode.value
        : state.breedList[0]['code'];
    Get.bottomSheet(Container(
        height: 200,
        color: Colors.white,
        alignment: Alignment.center,
        child: CupertinoPicker(
          magnification: 1.22,
          squeeze: 1.2,
          useMagnifier: true,
          itemExtent: 32.0,
          onSelectedItemChanged: (int selectedItem) {
            state.breedName.value = state.breedList[selectedItem]['name'];
            state.breedCode.value = state.breedList[selectedItem]['code'];
          },
          children: List<Widget>.generate(state.breedList.length, (int index) {
            return Center(
              child: Text(state.breedList[index]["name"]),
            );
          }),
        )));
  }

  void changeRecentHealth(int index) {
    print(111);
    final item = healthList[index];
    if (item['value'] == 'NONE' && !state.recentHealth.value.contains('NONE')) {
      state.recentHealth.update((val) {
        val?.removeRange(0, state.recentHealth.value.length);
        val?.insert(0, item['value']);
      });
    } else if (state.recentHealth.value.contains(item['value'])) {
      state.recentHealth.update((val) {
        val?.remove(item['value']);
      });
    } else {
      state.recentHealth.update((val) {
        if (state.recentHealth.value.contains('NONE')) {
          val?.remove('NONE');
        }
        val?.insert(0, item['value']);
      });
    }
  }
}
