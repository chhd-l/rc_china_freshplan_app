import 'package:flutter/material.dart';
import 'package:rc_china_freshplan_app/data/pet.dart';
import 'package:rc_china_freshplan_app/data/consumer.dart';
import 'storage.dart';

class PetUtil {
  static List<Pet> petList = [];
  static late Consumer? consumer;

  static void init() {
    consumer = StorageUtil().getJSON("loginUser") != null
        ? Consumer.fromJson(StorageUtil().getJSON("loginUser"))
        : null;
    if (consumer != null) {
      var petListInStorage =
          StorageUtil().getJSON('${consumer?.mobile}_petList');
      if (petListInStorage != null) {
        List<dynamic> list = List.from(petListInStorage);
        petList = List<Pet>.from(list.map((e) => Pet.fromJson(e)));
      }
    }
  }

  static void logout() {
    petList.clear();
  }

  static void addPet(Pet pet) {
    petList.add(pet);
    StorageUtil().setJSON('${consumer?.mobile}_petList', petList);
  }

  static Pet getPet(String id) {
    return petList.firstWhere((element) => element.id == id,
        orElse: () => Pet(
              id: '-1',
              name: '',
              image: '',
              type: '',
              gender: '',
              birthday: '',
              breedCode: '',
              breedName: '',
              recentHealth: [],
              targetWeight: 0.0,
              recentWeight: 0.0,
              recentPosture: '',
            ));
  }

  static void updatePet(Pet pet) {
    int idx = 0;
    petList.asMap().entries.forEach((element) {
      if (element.value.id == pet.id) {
        idx = element.key;
      }
    });
    petList.replaceRange(idx, idx + 1, [pet]);
    StorageUtil().setJSON('${consumer?.mobile}_petList', petList);
  }

  static void removePet(Pet pet) {
    int idx = 0;
    petList.asMap().entries.forEach((element) {
      if (element.value.id == pet.id) {
        idx = element.key;
      }
    });
    petList.replaceRange(idx, idx + 1, []);
    StorageUtil().setJSON('${consumer?.mobile}_petList', petList);
  }

  static void removeAllPet() {
    petList.clear();
    StorageUtil().remove('${consumer?.mobile}_petList');
  }
}
