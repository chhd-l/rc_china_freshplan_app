import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:rc_china_freshplan_app/common/util/event_bus.dart';
import 'package:rc_china_freshplan_app/common/util/utils.dart';
import 'package:rc_china_freshplan_app/common/widgets/factor.dart';
import 'package:rc_china_freshplan_app/data/pet.dart';
import 'package:rc_china_freshplan_app/data/consumer.dart';
import 'package:rc_china_freshplan_app/api/pet/index.dart';
import 'storage.dart';

import 'package:dio/src/multipart_file.dart' as DIOMUL;
import 'package:dio/src/form_data.dart' as DIOFORM;

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

  //select pet avatar start
  static selectImageType() {
    Get.bottomSheet(Container(
      height: 320,
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20))),
      child: Column(
        children: [
          Text("上传宠物头像", style: textSyle700(fontSize: 18)),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      tapHeadIcon('camera');
                      Get.back();
                    },
                    child: Image.asset(
                      'assets/images/carame-image.png',
                      width: 63,
                      height: 63,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text('去拍照', style: textSyle700(fontSize: 15)),
                ],
              ),
              Column(
                children: [
                  GestureDetector(
                      onTap: () {
                        tapHeadIcon('gallery');
                        Get.back();
                      },
                      child: Image.asset('assets/images/carame-image.png')),
                  const SizedBox(height: 16),
                  Text('相册选择', style: textSyle700(fontSize: 15)),
                ],
              )
            ],
          ),
          const SizedBox(height: 40),
          titleButton('取消', () {
            Get.back();
          }, height: 46, isCircle: true)
        ],
      ),
    ));
  }

  static Future upLoadImage(XFile image) async {
    var data = await PetEndPoint.uploadImage(image);
    return data;
  }

  static Future tapHeadIcon(type) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
        imageQuality: 80,
        maxWidth: 540,
        source: type == 'camera' ? ImageSource.camera : ImageSource.gallery);
    if (pickedFile != null) {
      await PetEndPoint.uploadImage(pickedFile).then((value) {
        EventBus().sendBroadcast('pet-avatar-update', value);
      });
    }
  }
  //select pet avatar end
}
