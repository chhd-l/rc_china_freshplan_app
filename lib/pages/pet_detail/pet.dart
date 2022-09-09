import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:rc_china_freshplan_app/data/pet.dart';
import 'package:intl/intl.dart';

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

  void initData(Pet pet) {
    name.value = pet.name!;
    gender.value = pet.gender!;
    type.value = pet.type!;
    breedCode.value = pet.breedCode!;
    breedName.value = pet.breedName!;
    image.value = pet.image!;
    birthday.value = pet.birthday!;
    recentWeight.value = pet.recentWeight!;
    recentPosture.value = pet.recentPosture!;
    targetWeight.value = pet.targetWeight!;
    recentHealth.value = pet.recentHealth!;
  }

  void changeBirthDay(DateTime d) {
    birthday.value = DateFormat('yyyy-MM-dd').format(d);
  }

  void changeGender(String sex) {
    gender.value = sex;
  }

  @override
  void onInit() {
    super.onInit();

    nameController.addListener(() {
      name.value = nameController.text;
    });
  }
}
