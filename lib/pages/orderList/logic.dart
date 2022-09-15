import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/api/order/index.dart';
import 'dart:convert';

class CreateOrderRessLogic extends GetxController {
  var tagType = 'ALL'.obs;

  void onChangeTagType (String text) => {
    tagType.value = text
  };
}