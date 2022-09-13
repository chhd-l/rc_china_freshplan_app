import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/state_manager.dart';
import 'package:rc_china_freshplan_app/data/pet.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rc_china_freshplan_app/common/util/http.dart';
import 'package:dio/src/multipart_file.dart' as DIOMUL;
import 'package:dio/src/form_data.dart' as DIOFORM;

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
  var recentHealth = [].obs;

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

    nameController =
        TextEditingController.fromValue(TextEditingValue(text: pet.name ?? ''));
    recentWeightController = TextEditingController.fromValue(
        TextEditingValue(text: pet.recentWeight.toString()));
    targetWeightController = TextEditingController.fromValue(
        TextEditingValue(text: pet.targetWeight.toString()));
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

  void changeBreed(int breed) {
    breedName.value = '金毛';
  }

  void changeRencentPosture(String posture) {
    recentPosture.value = posture;
  }

  void addRencentHealth(String health) {
    if (health == 'NONE') {
      recentHealth.value = ['NONE'];
    } else if (recentHealth.contains(health)) {
      recentHealth.remove("NONE");
      recentHealth.remove(health);
    } else {
      recentHealth.remove("NONE");
      recentHealth.add(health);
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

  void uploadPetImage(XFile image) async {
    String path = image.path;
    var name = path.substring(path.lastIndexOf("/") + 1, path.length);

    DIOFORM.FormData formdata = DIOFORM.FormData.fromMap(
        {"file": await DIOMUL.MultipartFile.fromFile(path, filename: name)});

    EasyLoading.show(status: 'loading...');
    HttpUtil()
        .post("https://fcdev.d2cgo.com/upload", params: formdata)
        .onError((ErrorEntity error, stackTrace) {
      EasyLoading.showError(error.message!);
    }).then((value) {
      EasyLoading.dismiss();
      if (value == null) return;
      print(value);
    });
  }
}
