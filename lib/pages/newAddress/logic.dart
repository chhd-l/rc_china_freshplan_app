import 'dart:convert';

import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/common/router/app_router.dart';
import 'package:rc_china_freshplan_app/common/util/address-util.dart';
import 'package:rc_china_freshplan_app/data/address.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CreateAddRessLogic extends GetxController {
  var id = DateTime.now().microsecondsSinceEpoch.toString().obs;
  var receiverName = ''.obs;
  var phone = ''.obs;
  var province = ''.obs;
  var city = ''.obs;
  var region = ''.obs;
  var detail = ''.obs;
  var isDefault = false.obs;

  void onChangeID(String text) => {id.value = text};

  void onChangeName(String text) => {receiverName.value = text};

  void onChangephone(String text) => {phone.value = text};

  void onChangeprovince(String text) => {province.value = text};

  void onChangecity(String text) => {city.value = text};

  void onChangeregion(String text) => {region.value = text};

  void onChangedetail(String text) => {detail.value = text};

  void onChangeisDefault(bool text) => {isDefault.value = text};

  void initData(args) {
    var addRess = AddRessUtil.getAddRess(args);
    receiverName.value = addRess.receiverName!;
    phone.value = addRess.phone!;
    province.value = addRess.province!;
    city.value = addRess.city!;
    region.value = addRess.region!;
    detail.value = addRess.detail!;
    isDefault.value = addRess.isDefault!;
  }

  void recommendedRecipes(String updid) async {
    if (receiverName.isEmpty ||
        phone.isEmpty ||
        province.isEmpty ||
        city.isEmpty ||
        region.isEmpty ||
        detail.isEmpty) {
      EasyLoading.showToast("请填入完整信息");
      return;
    }
    RegExp reg =
        RegExp(r'^1(?:3\d|4[4-9]|5[0-35-9]|6[67]|7[013-8]|8\d|9\d)\d{8}$');
    if (!reg.hasMatch(phone.value)) {
      EasyLoading.showToast("联系电话格式不正确");
      return;
    }
    AddRess addRess = AddRess(
      receiverName: receiverName.value,
      id: updid != '-1' ? updid : id.value,
      phone: phone.value,
      province: province.value,
      city: city.value,
      region: region.value,
      detail: detail.value,
      isDefault: isDefault.value,
    );
    print(addRess.toJson());
    dynamic flag;
    if (updid != '-1') {
      flag = await AddRessUtil.updateAddRess(addRess);
    } else {
      flag = await AddRessUtil.addRes(addRess);
    }
    if (flag != false) {
      Get.back(result: true); //返回列表刷新地址
    }
  }
}
