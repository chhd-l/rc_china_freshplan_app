import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/common/router/app_router.dart';
import 'package:rc_china_freshplan_app/common/util/storage.dart';
import 'package:rc_china_freshplan_app/common/util/utils.dart';
import 'package:rc_china_freshplan_app/data/consumer.dart';
import 'package:rc_china_freshplan_app/pages/checkout/pay_request_params.dart';
import 'package:rc_china_freshplan_app/global.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:rc_china_freshplan_app/common/util/http.dart';
import 'package:rc_china_freshplan_app/common/values/api_path.dart';
import 'package:tobias/tobias.dart' as tobias;

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
    if (global.selectProduct.contains(element["variants"][0]["id"])) {
      state.orderProduct.insert(0, element);
      state.productTotalPrice.value = state.productTotalPrice.value +
          int.parse(element["variants"][0]['subscriptionPrice'].toString()) * 6;
      state.payTotalPrice.value = (state.productTotalPrice.value -
          state.discountPrice -
          state.newDiscountPrice -
          state.deliveryPrice);
    }
  }

  //支付
  pay() async {
    if (global.checkoutAddress.value.id == null) {
      EasyLoading.showInfo('please select your address');
      return;
    }

    var payParams = handlePayParams();

    EasyLoading.show();
    HttpUtil()
        .post(getPayInfo, params: payParams)
        .onError((ErrorEntity error, stackTrace) {
      EasyLoading.showError(error.message!);
    }).then((value) async {
      EasyLoading.dismiss();
      if (value == null) return;
      value = json.decode(value.toString());
      var payInfo = value["data"]["subscriptionCreateAndPay"]
          ["paymentStartResult"]["aliPaymentRequest"]["orderStr"];
      var result = await tobias.aliPay(payInfo);
      print(result);
      if (result["resultStatus"].toString() == '9000' ||
          result["resultStatus"].toString() == '6001') {
        //9000 订单支付成功  6000 用户中途取消
        Get.offAllNamed(AppRoutes.orderList);
      }
    });
  }

  handlePayParams() {
    var consumer = Consumer.fromJson(StorageUtil().getJSON('loginUser'))
        .payConsumerToJson();

    var pet = json.decode(json.encode(global.checkoutPet.value.toJson()));
    pet["recentHealth"] = (pet["recentHealth"] ?? []).join('|');
    pet["birthday"] =
        handleDateTimeToZone(DateTime.parse(pet["birthday"].toString()));

    var address = global.checkoutAddress.value.clonePayAddressToJson();

    var productList = json.decode(json.encode(state.orderProduct));
    for (var element in productList) {
      element["variants"] = element["variants"][0];
      element["variants"]["num"] = 6;
    }
    var payParams = {
      "query": subscriptionCreateAndPayQuery,
      "variables": {
        "input": {
          "description": "description",
          "type": "FRESH_PLAN",
          "cycle": null,
          "freshType": null,
          "voucher": null,
          "consumer": consumer,
          "pet": pet,
          "source": "ALIPAY_MINI_PROGRAM",
          "address": address,
          "productList": productList,
          "benefits": null,
          "coupons": null,
          "remark": remarkController.text,
          "firstDeliveryTime": handleDateTimeToZone(DateTime.now()),
          "totalDeliveryTimes": 6
        },
        "payWayId": "ALI_PAY_APP",
        "storeId": "39b6444b-683b-4915-8b75-5d8403f40a02",
        "operator": "Timyee"
      }
    };
    return payParams;
  }
}
