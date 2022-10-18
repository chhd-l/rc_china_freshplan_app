import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/api/consumer/index.dart';
import 'package:rc_china_freshplan_app/common/util/httpForThree.dart';

class PlanDetailLogic extends GetxController {
  final appSecret = '5ate975gpiv9we6p';
  final appKey = 'N790KtqEKXZujq08';

  RxString url = ''.obs;

  @override
  void onReady() {
    getInvoiceToken();
    super.onReady();
  }

  getInvoiceToken() {
    String consumerId = ConsumerEndPoint.getLoggedConsumerId();
    EasyLoading.show();
    HttpUtil().get('https://fapiao-api.easyapi.com/access-token', params: {
      "appKey": appKey,
      "appSecret": appSecret,
      "username": consumerId,
    }).onError((ErrorEntity error, stackTrace) {
      EasyLoading.showError(error.message!);
    }).then((value) async {
      EasyLoading.dismiss();
      if (value == null) return;
      value = json.decode(value.toString());
      print(value);
      print(value["content"]["accessToken"]);
      url.value =
          'https://fapiao-h5.easyapi.com?accessToken=4ej9r9psboydrx5ywr8c6ouppkopt7w5}';
      if (value["code"] != 1) {
        EasyLoading.showError(value["message"] ?? '获取token失败');
      }
    });
  }
}
