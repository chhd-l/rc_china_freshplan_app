import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/common/router/app_router.dart';
import 'package:rc_china_freshplan_app/data/payRequestParams.dart';
import 'package:rc_china_freshplan_app/global.dart';
import 'package:sy_flutter_alipay/sy_flutter_alipay.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:rc_china_freshplan_app/common/util/http.dart';
import 'package:rc_china_freshplan_app/common/values/api_path.dart';

import 'state.dart';

class CheckoutLogic extends GetxController {
  final state = CheckoutState();

  final global = Get.put(GlobalConfigService());

  TextEditingController remarkController = TextEditingController();

  @override
  void onReady() {
    for (var element in global.recipesList) {
      setOrderProduct(element);
    }
    super.onReady();
  }

  setOrderProduct(element) {
    if (global.selectProduct.contains(element['value'])) {
      state.orderProduct.insert(0, element);
      state.productTotalPrice.value = state.productTotalPrice.value +
          int.parse(element['price'].toString());
      state.payTotalPrice.value = (state.productTotalPrice.value -
          state.discountPrice -
          state.newDiscountPrice -
          state.deliveryPrice);
    }
  }

  handlePrice(value, {isDiscount = false}) {
    return isDiscount ? '-￥$value.00' : '￥$value.00';
  }

  //支付
  pay() async {
    EasyLoading.show(status: 'loading orderInfo...');
    HttpUtil()
        .post(getPayInfo, params: getPayInfoParams)
        .onError((ErrorEntity error, stackTrace) {
      EasyLoading.showError(error.message!);
    }).then((value) async {
      EasyLoading.dismiss();
      if (value == null) return;
      value = json.decode(value.toString());
      print("支付串");
      print(value["data"]["subscriptionCreateAndPay"]["paymentStartResult"]
          ["aliPaymentRequest"]["orderStr"]);
      // var payInfo =
      //     'alipay_sdk=alipay-sdk-java-3.0.52.ALL&app_id=2017091208686178&biz_content=%7B%22out_trade_no%22%3A%22T_62536%22%2C%22total_amount%22%3A%220.01%22%2C%22subject%22%3A%22%E4%BA%A4%E9%80%9A%E5%AD%A6%E9%99%A2%E7%BD%91%E7%82%B9%E6%B4%97%E8%BD%A6%E6%9C%8D%E5%8A%A1%22%2C%22timeout_express%22%3A%2230m%22%7D&charset=UTF-8&format=json&method=alipay.trade.app.pay&notify_url=https%3A%2F%2Ftpwashlocal.taipuauto.cn%2Fpay%2Fnotify%2Fwash%2Forder%2Fali&sign=RBlcOkoJ3FRQVHATnRDvWi8c4iU1d8kKLIq4lfgA2AbuDcDTH%2FUTeROXNVQQG7EPYfVOK48i1vaIUJB5BmycaRKDSIEOh4qkUS1SbBb3RpBfpKjqs1DFs7uIwccBO%2Bi9Qu%2BDQLvhdyfa%2FrLaEtSlMNzbRRUrEIPSSw5b7ZMDVFVuZleZ5JpQLq3VqGwOUvZ9jVb903B8b867c1LfkgWL3JlgweT3gmATGEg2junnAb3Xitznb4IHQUb8QzQT9oFx0paS1ojKRhkDMCMyCJyOWLxotxbFTu66xGIzdGlD4FEnaMesp9H4AKkB2XgqkT2QQOvSRZdAoigY20cuTBBUQA%3D%3D&sign_type=RSA2&timestamp=2020-03-24+14%3A41%3A26&version=1.0';
      var payInfo = value["data"]["subscriptionCreateAndPay"]
          ["paymentStartResult"]["aliPaymentRequest"]["orderStr"];
      var result = await SyFlutterAlipay.pay(payInfo,
          urlScheme: 'paydemo', isSandbox: false);
      print(22222);
      print(result);
      if (result["resultStatus"].toString() == '9000') {
        //订单支付成功
        Get.offAllNamed(AppRoutes.orderList);
      }
      if (result["resultStatus"].toString() == '6001') {
        //用户中途取消
        Get.offAllNamed(AppRoutes.orderList);
      }
    });
  }
}
