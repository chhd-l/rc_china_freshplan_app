import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_pickers/style/picker_style.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/src/multipart_file.dart' as DIOMUL;
import 'package:dio/src/form_data.dart' as DIOFORM;
import 'package:intl/intl.dart';
import 'package:rc_china_freshplan_app/common/router/app_router.dart';
import 'package:rc_china_freshplan_app/common/util/http.dart';
import 'package:rc_china_freshplan_app/common/util/pet-util.dart';
import 'package:rc_china_freshplan_app/common/values/api_path.dart';
import 'package:rc_china_freshplan_app/common/widgets/factor.dart';
import 'package:rc_china_freshplan_app/data/pet.dart';
import 'package:rc_china_freshplan_app/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_pickers/pickers.dart';

import 'state.dart';

class CreatePetLogic extends GetxController {
  final state = CreatePetState();

  final global = Get.put(GlobalConfigService());

  TextEditingController petNameController = TextEditingController();

  FocusNode petNameFocusNode = FocusNode();

  final List healthList = [
    {'name': '对食物很挑剔', 'value': 'PICKY_EATER'},
    {'name': '食物过敏或胃敏感', 'value': 'FOOD_ALLERGIES_OR_STOMACH_SENSITIVITIES'},
    {'name': '无光泽或片状被毛', 'value': 'DULL_OR_FLAKY_FUR'},
    {'name': '关节炎或关节痛', 'value': 'ARTHRITIS_OR_JOINT_PAIN'},
    {'name': '以上都没有', 'value': 'NONE'},
  ];

  @override
  void onInit() {
    super.onInit();

    petNameController.addListener(() {
      state.name.value = petNameController.text;
    });
  }

  isCanNext(showTip) {
    switch (state.currentStep.value) {
      case 2:
        if (state.name.value == '' && showTip) {
          EasyLoading.showInfo('请填写宠物昵称');
        }
        if (state.gender.value == '' && showTip) {
          EasyLoading.showInfo('请选择宠物性别');
        }
        return state.name.value != '' && state.gender.value != '';
      case 3:
        if (state.breedName.value == '' && showTip) {
          EasyLoading.showInfo('请选择宠物品种');
        }
        return state.breedName.value != '' && state.breedCode.value != '';
      case 4:
        return state.birthday.value != '';
      case 5:
        if (state.isSterilized.value == '' && showTip) {
          EasyLoading.showInfo('请选择宠物绝育状态');
        }
        return state.isSterilized.value != '';
      case 6:
        if (state.recentWeight.value == 0.0 && showTip) {
          EasyLoading.showInfo('请选择宠物近期体重');
        }
        if (state.recentPosture.value == '' && showTip) {
          EasyLoading.showInfo('请选择宠物近期状态');
        }
        if (state.targetWeight.value == 0.0 && showTip) {
          EasyLoading.showInfo('请选择宠物近期成年目标体重');
        }
        return state.recentWeight.value != 0.0 &&
            state.targetWeight.value != 0.0 &&
            state.recentPosture.value != '';
    }
    return true;
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
    DIOFORM.FormData formdata = DIOFORM.FormData.fromMap(
        {"file": await DIOMUL.MultipartFile.fromFile(path, filename: name)});

    EasyLoading.show();
    HttpUtil()
        .post(upload, params: formdata)
        .onError((ErrorEntity error, stackTrace) {
      EasyLoading.showError(error.message!);
    }).then((value) {
      EasyLoading.dismiss();
      if (value == null) return;
      state.avatar.value = json.decode(value.toString())["url"];
    });
  }

  void recommendedRecipes() async {
    Pet pet = Pet(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: state.name.value,
      gender: state.gender.value,
      type: state.type.value,
      breedCode: state.breedCode.value,
      breedName: state.breedName.value,
      image: state.avatar.value,
      isSterilized: false,
      birthday: state.birthday.value,
      recentWeight: state.recentWeight.value,
      recentPosture: state.recentPosture.value,
      targetWeight: state.targetWeight.value,
      recentHealth: state.recentHealth.value,
    );
    print(pet.toJson());
    var createFlag = await PetUtil.addPet(pet);
    if (createFlag != false) {
      global.checkoutPet.value = pet;
      Get.toNamed(AppRoutes.recommendRecipes);
    }
  }

  void changeType(value) {
    state.type.value = value;
    state.breedList.value =
        value == 'DOG' ? global.dogBreedList : global.catBreedList;
    state.currentStep.value += 1;
  }

  void changeGender(value) {
    state.gender.value = value;
    if (state.name.value != '') {
      state.currentStep.value += 1;
    }
  }

  void selectBirthday() {
    state.birthday.value = state.birthday.value != ''
        ? state.birthday.value
        : DateFormat("yyyy-MM-dd").format(DateTime.now()).toString();
    Get.bottomSheet(
        Container(
          height: 350,
          padding: const EdgeInsets.all(20),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            color: Colors.white,
          ),
          child: Column(
            children: [
              const SizedBox(height: 8),
              Text('选择爱宠生日', style: textSyle700(fontSize: 20)),
              SizedBox(
                  height: 180,
                  child: CupertinoDatePicker(
                    onDateTimeChanged: (dateTime) {
                      state.birthday.value =
                          DateFormat("yyyy-MM-dd").format(dateTime).toString();
                    },
                    initialDateTime: DateTime.now(),
                    minuteInterval: 1,
                    mode: CupertinoDatePickerMode.date,
                  )),
              const SizedBox(height: 20),
              titleButton('确定', () {
                state.currentStep.value += 1;
                Get.back();
              }, isCircle: true)
            ],
          ),
        ),
        persistent: false);
  }

  void selectNormalBreed(breed) {
    state.breedName.value = breed["name"];
    state.breedCode.value = breed["code"];
    state.currentStep.value += 1;
  }

  void selectBreed() {
    state.breedName.value = state.breedName.value != ''
        ? state.breedName.value
        : state.breedList[0]['name'];
    state.breedCode.value = state.breedCode.value != ''
        ? state.breedCode.value
        : state.breedList[0]['code'];
    Get.bottomSheet(
        Container(
            height: 200,
            color: Colors.white,
            alignment: Alignment.center,
            child: CupertinoPicker(
              magnification: 1.22,
              squeeze: 1.2,
              useMagnifier: true,
              itemExtent: 32.0,
              onSelectedItemChanged: (int selectedItem) {
                state.breedName.value = state.breedList[selectedItem]['name'];
                state.breedCode.value = state.breedList[selectedItem]['code'];
              },
              children:
                  List<Widget>.generate(state.breedList.length, (int index) {
                return Center(
                  child: Text(state.breedList[index]["name"]),
                );
              }),
            )),
        persistent: false);
  }

  void changeRecentHealth(int index) {
    print(111);
    final item = healthList[index];
    if (item['value'] == 'NONE' && !state.recentHealth.value.contains('NONE')) {
      state.recentHealth.update((val) {
        val?.removeRange(0, state.recentHealth.value.length);
        val?.insert(0, item['value']);
      });
    } else if (state.recentHealth.value.contains(item['value'])) {
      state.recentHealth.update((val) {
        val?.remove(item['value']);
      });
    } else {
      state.recentHealth.update((val) {
        if (state.recentHealth.value.contains('NONE')) {
          val?.remove('NONE');
        }
        val?.insert(0, item['value']);
      });
    }
  }

  void selectWeight(context, type) {
    Pickers.showMultiPicker(
      context,
      data: [
        List.generate(70, (index) => index.toString()).toList(),
        ['·'],
        List.generate(9, (index) => index.toString()).toList()
      ],
      selectData: [1, '·', 0],
      onConfirm: (List index, List strData) {
        print('longer >>> 返回数据类型：${strData[0]}');
        if (type == 'now') {
          state.recentWeight.value = double.parse(
              '${jsonEncode(strData[0]).toString()}.${jsonEncode(strData[2]).toString()}');
        }
        if (type == 'target') {
          state.targetWeight.value = double.parse(
              '${jsonEncode(strData[0]).toString()}.${jsonEncode(strData[2]).toString()}');
        }
      },
    );
  }
}
