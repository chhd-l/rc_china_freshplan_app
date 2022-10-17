import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:rc_china_freshplan_app/common/values/colors.dart';
import 'package:rc_china_freshplan_app/common/widgets/factor.dart';
import 'package:rc_china_freshplan_app/data/pet.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rc_china_freshplan_app/common/util/http.dart';
import 'package:dio/src/multipart_file.dart' as DIOMUL;
import 'package:dio/src/form_data.dart' as DIOFORM;
import 'package:rc_china_freshplan_app/common/values/api_path.dart';
import 'package:rc_china_freshplan_app/pages/breedPicker/view.dart';

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
  var recentHealth = Rx<List<String>>([]);
  dynamic isSterilized = ''.obs;

  int weight1 = 0;
  int weight2 = 0;

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

    nameController.text = pet.name ?? '';
    recentWeightController.text = pet.recentWeight.toString();
    targetWeightController.text = pet.targetWeight.toString();
  }

  @override
  void onInit() {
    super.onInit();

    nameController.addListener(() {
      name.value = nameController.text;
    });

    recentWeightController.addListener(() {
      recentWeight.value =
          double.tryParse(recentWeightController.text.toString()) ?? 0.0;
    });

    targetWeightController.addListener(() {
      targetWeight.value =
          double.tryParse(targetWeightController.text.toString()) ?? 0.0;
    });
  }

  @override
  void onClose() {
    super.onClose();
    name.value = "";
    gender.value = "";
    type.value = "";
    breedCode.value = "";
    breedName.value = "";
    image.value = "";
    birthday.value = "";
    recentWeight.value = 0.0;
    targetWeight.value = 0.0;
    recentPosture.value = "";
    recentHealth.value = [];
    nameController.clear();
    recentWeightController.clear();
    targetWeightController.clear();
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

  void changeBreed(String name, String code) {
    breedName.value = name;
    breedCode.value = code;
  }

  void changeRencentPosture(String posture) {
    recentPosture.value = posture;
  }

  void addRencentHealth(String health) {
    if (health == 'NONE') {
      recentHealth.value = ['NONE'];
    } else if (recentHealth.value.contains(health)) {
      recentHealth.update((val) {
        val?.remove("NONE");
        val?.remove(health);
      });
    } else {
      recentHealth.update((val) {
        val?.remove("NONE");
        val?.add(health);
      });
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

  void uploadPetImage(XFile file) async {
    String path = file.path;
    var name = path.substring(path.lastIndexOf("/") + 1, path.length);

    // state.avatar.value = path;

    DIOFORM.FormData formdata = DIOFORM.FormData.fromMap(
        {"file": await DIOMUL.MultipartFile.fromFile(path, filename: name)});

    EasyLoading.show();
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
      image.value = json.decode(value.toString())["url"];
      print(image.value);
    });
  }

  void selectBreed() {
    Get.to(() => BreedListPickerPage(), fullscreenDialog: true, arguments: {
      'petType': type.value,
      "callback": (name, code) {
        breedName.value = name;
        breedCode.value = code;
      }
    });
  }

  void changeIsSterilized(value) {
    isSterilized = value;
  }

  void selectWeight(context, type) {
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
                const Text(
                  "选择爱宠近期体重(公斤)",
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 17,
                  ),
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
                      const Text(
                        ".",
                        style: TextStyle(
                          color: AppColors.primaryText,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                )),
                titleButton("确定", () {
                  if (type == 'now') {
                    recentWeight.value = double.parse(
                        '${weight1.toString()}.${weight2.toString()}');
                  }
                  if (type == 'target') {
                    targetWeight.value = double.parse(
                        '${weight1.toString()}.${weight2.toString()}');
                  }
                  Get.back();
                }, isCircle: true)
              ],
            ))),
        persistent: false);
  }

  Widget _cupertinoCountPicker(int count, Function(int)? callback) {
    return CupertinoPicker(
      selectionOverlay: _selectionOverlay(),
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

  _selectionOverlay() {
    return Padding(
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
    );
  }
}
