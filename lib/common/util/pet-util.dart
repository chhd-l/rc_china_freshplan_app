import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rc_china_freshplan_app/common/util/utils.dart';
import 'package:rc_china_freshplan_app/data/pet.dart';
import 'package:rc_china_freshplan_app/data/consumer.dart';
import 'package:rc_china_freshplan_app/api/pet/index.dart';
import 'storage.dart';

class PetUtil {
  static List<Pet> petList = [];
  static late Consumer? consumer;

  static Pet normalizeFromApi(dynamic data) {
    return Pet(
      id: data['id'],
      name: data['name'],
      gender: data['gender'],
      type: data['type'],
      breedCode: data['breedCode'],
      breedName: data['breedName'],
      image: data['image'],
      isSterilized: data['isSterilized'],
      birthday: handleDateFromApi(data['birthday']),
      recentWeight: double.tryParse(data['recentWeight'].toString()) ?? 0.0,
      targetWeight: double.tryParse(data['targetWeight'].toString()) ?? 0.0,
      recentPosture: data['recentPosture'],
      recentHealth: data['recentHealth'].toString().split('|'),
      subscriptionNo: data['subscriptionNo'].cast<String>(),
    );
  }

  static Map<String, dynamic> normalizeToApi(Pet pet, {bool needId = false}) {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (needId) {
      data['id'] = pet.id;
    }
    data['name'] = pet.name;
    data['gender'] = pet.gender;
    data['type'] = pet.type;
    data['breedCode'] = pet.breedCode;
    data['breedName'] = pet.breedName;
    data['image'] = pet.image;
    data['isSterilized'] = pet.isSterilized;
    data['birthday'] = DateTime.parse(pet.birthday!).toUtc().toIso8601String();
    data['recentWeight'] = pet.recentWeight;
    data['targetWeight'] = pet.targetWeight;
    data['recentPosture'] = pet.recentPosture;
    data['recentHealth'] = (pet.recentHealth ?? []).join('|');
    return data;
  }

  static Future<List<Pet>> getPetList() async {
    var list = await PetEndPoint.getPetList();
    petList = list;
    return list;
  }

  static Future<void> init() async {
    consumer = StorageUtil().getJSON("loginUser") != null
        ? Consumer.fromJson(StorageUtil().getJSON("loginUser"))
        : null;
    if (consumer != null) {
      var petListInStorage =
          StorageUtil().getJSON('${consumer?.phone}_petList');
      if (petListInStorage != null) {
        List<dynamic> list = List.from(petListInStorage);
        petList = List<Pet>.from(list.map((e) => Pet.fromJson(e)));
      }
    }
  }

  static void logout() {
    petList.clear();
  }

  static Future addPet(Pet pet) {
    return PetEndPoint.createPet(pet);
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

  static Future<bool> updatePet(Pet pet) {
    return PetEndPoint.updatePet(pet);
  }

  static Future<bool> removePet(Pet pet) {
    return PetEndPoint.deletePet(pet.id!);
  }

  static void removeAllPet() {
    petList.clear();
    StorageUtil().remove('${consumer?.phone}_petList');
  }
}
