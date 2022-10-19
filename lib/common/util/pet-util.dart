import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:rc_china_freshplan_app/common/util/event_bus.dart';
import 'package:rc_china_freshplan_app/common/util/utils.dart';
import 'package:rc_china_freshplan_app/common/values/colors.dart';
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

  //select pet weight start
  static selectWeight(context, type) {
    int weight1 = 0;
    int weight2 = 0;
    Get.bottomSheet(
        Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
            height: 350,
            color: Colors.white,
            alignment: Alignment.center,
            child: SafeArea(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "选择爱宠近期体重(公斤)",
                  style: textSyle700(fontSize: 17),
                ),
                Expanded(
                    child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Row(children: [
                        Expanded(
                            child: _cupertinoCountPicker(71, (i) {
                          weight1 = i;
                        })),
                        Expanded(
                            child: _cupertinoCountPicker(10, (i) {
                          weight2 = i;
                        })),
                      ]),
                      Text(
                        ".",
                        style: textSyle700(fontSize: 20),
                      ),
                    ],
                  ),
                )),
                titleButton("确定", () {
                  if (type == 'now') {
                    EventBus().sendBroadcast(
                        'pet-recent-weight-update',
                        double.parse(
                            '${weight1.toString()}.${weight2.toString()}'));
                  }
                  if (type == 'target') {
                    EventBus().sendBroadcast(
                        'pet-target-weight-update',
                        double.parse(
                            '${weight1.toString()}.${weight2.toString()}'));
                  }
                  Get.back();
                }, isCircle: true)
              ],
            ))),
        persistent: false);
  }

  static  Widget _cupertinoCountPicker(int count, Function(int)? callback) {
    return CupertinoPicker(
      selectionOverlay: Padding(
        padding: EdgeInsets.zero,
        child: Column(
          children: const [
            Divider(
              height: 1,
              color: Colors.grey,
            ),
            Spacer(),
            Divider(
              height: 1,
              color: Colors.grey,
            ),
          ],
        ),
      ),
      magnification: 1.22,
      squeeze: 1.2,
      useMagnifier: true,
      itemExtent: 32.0,
      onSelectedItemChanged: callback,
      children: List<Widget>.generate(count, (int index) {
        return Center(
          child: Text((index).toString()),
        );
      }),
    );
  }
//select pet weight end

}
