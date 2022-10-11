import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/common/util/address-util.dart';
import 'package:rc_china_freshplan_app/common/values/colors.dart';
import 'package:rc_china_freshplan_app/data/address.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:city_pickers/city_pickers.dart';

class CreateAddressLogic extends GetxController {
  var id = DateTime.now().microsecondsSinceEpoch.toString().obs;
  var receiverName = ''.obs;
  var phone = ''.obs;
  var province = ''.obs;
  var city = ''.obs;
  var region = ''.obs;
  var detail = ''.obs;
  var isDefault = false.obs;

  TextEditingController contNameroller = TextEditingController();

  TextEditingController contPhoneroller = TextEditingController();

  TextEditingController contDateliroller = TextEditingController();

  void onChangeID(String text) => {id.value = text};

  void onChangeName(String text) => {receiverName.value = text};

  void onChangephone(String text) => {phone.value = text};

  void onChangedetail(String text) => {detail.value = text};

  void onChangeisDefault(bool text) => {isDefault.value = text};

  void initData(args) {
    var address = AddRessUtil.getAddRess(args);
    print(address);
    if (address.id != '-1') {
      receiverName.value = address.receiverName!;
      phone.value = address.phone!;
      province.value = address.province!;
      city.value = address.city!;
      region.value = address.region!;
      detail.value = address.detail!;
      isDefault.value = address.isDefault!;
      contNameroller.text = address.receiverName!;
      contPhoneroller.text = address.phone!;
      contDateliroller.text = address.detail!;
    }
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
    AddRess address = AddRess(
      receiverName: receiverName.value,
      id: updid != '-1' ? updid : id.value,
      phone: phone.value,
      province: province.value,
      city: city.value,
      region: region.value,
      detail: detail.value,
      isDefault: isDefault.value,
    );
    print(address.toJson());
    dynamic flag;
    if (updid != '-1') {
      flag = await AddRessUtil.updateAddRess(address);
    } else {
      flag = await AddRessUtil.addRes(address);
    }
    if (flag != false) {
      Get.back(result: true); //返回列表刷新地址
    }
  }

  void cityPicker(BuildContext context) async {
    Result resultArr = Result();
    Result? tempResult = await CityPickers.showCityPicker(
        context: context,
        theme:
            Theme.of(context).copyWith(primaryColor: Color(0xfffe1314)), // 设置主题
        locationCode: resultArr != null
            ? resultArr.areaId ??
                resultArr.cityId ??
                resultArr.provinceId ??
                '110000'
            : '110000', // 初始化地址信息
        cancelWidget: const Text('取消',
            style: TextStyle(fontSize: 15, color: AppColors.text999)),
        confirmWidget: const Text('确定',
            style: TextStyle(fontSize: 15, color: AppColors.tint)),
        height: 220.0);
    print(tempResult);
    if (tempResult != null) {
      province.value = tempResult.provinceName!;
      city.value = tempResult.cityName!;
      region.value = tempResult.areaName!;
      print(province.value);
      // setState(() {
      //   resultArr = tempResult;
      // });
    }
  }
}
