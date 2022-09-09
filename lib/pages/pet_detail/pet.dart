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
  var recentWeightController = TextEditingController();
  var targetWeightController = TextEditingController();

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

  @override
  void onInit() {
    super.onInit();

    nameController.addListener(() {
      name.value = nameController.text;
    });

    recentWeightController.addListener(() {
      double? v = double.tryParse(recentWeightController.text);
      recentWeight.value = v ?? 0.0;
    });

    targetWeightController.addListener(() {
      double? v = double.tryParse(targetWeightController.text);
      targetWeight.value = v ?? 0.0;
    });
  }
}
