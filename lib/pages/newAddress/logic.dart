
import 'dart:convert';

import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/common/router/app_router.dart';
import 'package:rc_china_freshplan_app/data/address.dart';
import '../../common/util/addRess-util.dart';

class CreateAddRessLogic extends GetxController {

  var id = DateTime.now().microsecondsSinceEpoch.toString().obs;
  var receiverName = ''.obs;
  var phone = ''.obs;
  var province = ''.obs;
  var city = ''.obs;
  var region = ''.obs;
  var detail = ''.obs;
  var isDefault = false.obs;
  
  void onChangeID (String text) => {
    id.value = text
  };

  void onChangeName (String text) => {
    receiverName.value = text
  };

  void onChangephone (String text) => {
    phone.value = text
  };

  void onChangeprovince (String text) => {
    province.value = text
  };

  void onChangedetail (String text) => {
    detail.value = text
  };

  void onChangeisDefault (bool text) => {
    isDefault.value = text
  };

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

  void recommendedRecipes(String updid) {
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
    updid != '-1' ? AddRessUtil.updateAddRess(addRess) : AddRessUtil.addRes(addRess);
    Get.back();
  }

}