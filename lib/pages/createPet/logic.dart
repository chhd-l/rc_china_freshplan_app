import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/src/multipart_file.dart' as DIOMUL;
import 'package:dio/src/form_data.dart' as DIOFORM;
import 'package:rc_china_freshplan_app/common/router/app_router.dart';
import 'package:rc_china_freshplan_app/common/util/http.dart';
import 'package:rc_china_freshplan_app/common/util/pet-util.dart';
import 'package:rc_china_freshplan_app/common/values/api_path.dart';
import 'package:rc_china_freshplan_app/data/pet.dart';
import 'package:rc_china_freshplan_app/global.dart';

import 'state.dart';

class CreatePetLogic extends GetxController {
  final state = CreatePetState();

  TextEditingController petNameController = TextEditingController();
  TextEditingController recentWeightController = TextEditingController();
  TextEditingController targetWeightController = TextEditingController();

  final List healthList = [
    {'name': '对食物很挑剔', 'value': '对食物很挑剔'},
    {'name': '食物过敏或胃敏感', 'value': '食物过敏或胃敏感'},
    {'name': '无光泽或片状被毛', 'value': '无光泽或片状被毛'},
    {'name': '关节炎或关节痛', 'value': '关节炎或关节痛'},
    {'name': '以上都没有', 'value': '以上都没有'},
  ];

  @override
  void onInit() {
    super.onInit();

    petNameController.addListener(() {
      state.name.value = petNameController.text;
    });

    recentWeightController.addListener(() {
      state.recentWeight.value = double.parse(recentWeightController.text.toString());
    });

    targetWeightController.addListener(() {
      state.targetWeight.value = double.parse(targetWeightController.text.toString());
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

    // state.avatar.value = path;

    DIOFORM.FormData formdata = DIOFORM.FormData.fromMap(
        {"file": await DIOMUL.MultipartFile.fromFile(path, filename: name)});

    EasyLoading.show(status: 'loading...');
    HttpUtil()
        .post(upload, params: formdata)
        .onError((ErrorEntity error, stackTrace) {
      print('333333');
          print(error.message);
      EasyLoading.showError(error.message!);
    }).then((value) {
      EasyLoading.dismiss();
      print('11111');
      print(value);
      if (value == null) return;
      state.avatar.value = json.decode(value.toString())["url"];
      print(state.avatar.value);
    });
  }

  void recommendedRecipes() {
    Get.put(GlobalConfigService()).petName.value = state.name.value;
    Pet pet = Pet(
      id: '1',
      name: state.name.value,
      gender: state.gender.value,
      type: state.type.value,
      breedCode: state.breedName.value,
      breedName: state.breedName.value,
      image: state.avatar.value,
      isSterilized: false,
      birthday: state.birthday.value,
      recentWeight: state.recentWeight.value,
      recentPosture: state.recentPosture.value,
      targetWeight: state.targetWeight.value,
      recentHealth: state.recentHealth.value,
    );
    PetUtil.addPet(pet);

    Get.toNamed(AppRoutes.recommendRecipes);
  }
}
