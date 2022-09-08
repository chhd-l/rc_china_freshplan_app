import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/src/multipart_file.dart' as DIOMUL;
import 'package:dio/src/form_data.dart' as DIOFORM;

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
      state.recentWeight.value = double.parse(recentWeightController.text);
    });

    targetWeightController.addListener(() {
      state.targetWeight.value = double.parse(targetWeightController.text);
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

    state.avatar.value = path;

    DIOFORM.FormData formdata = DIOFORM.FormData.fromMap(
        {"file": await DIOMUL.MultipartFile.fromFile(path, filename: name)});

    // EasyLoading.show(status: 'loading...');
    // HttpUtil()
    //     .post(FILE_UPLOAD, params: formdata)
    //     .onError((ErrorEntity error, stackTrace) {
    //   EasyLoading.showError(error.message!);
    // }).then((value) {
    //   EasyLoading.dismiss();
    //   if (value == null) return;
    //   state.petPlan.avatar = value;
    //   state.headImagePath.value = value;
    //   Get.put(GlobalConfigService()).save();
    // bus.sendBroadcast('pet_avatar_update');
    // });
  }
}
