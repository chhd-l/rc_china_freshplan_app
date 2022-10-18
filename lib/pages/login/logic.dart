import 'dart:convert';

import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/common/router/app_router.dart';
import 'package:rc_china_freshplan_app/common/util/http.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:rc_china_freshplan_app/common/values/api_path.dart';
import 'package:tobias/tobias.dart' as tobias;

class LoginLogic extends GetxController {
  //支付
  pay() async {
    var result = await tobias.aliPayAuth(
        "product_id=APP_FAST_LOGIN&scope=auth_user&apiname=com.alipay.account.auth&auth_type=AUTHACCOUNT&biz_type=openservice&pid=2088212966649221&sign_type=RSA2&target_id=test0001&app_id=2021003115605408&app_name=mc&method=alipay.open.auth.sdk.code.getsign=X06V5tjPgXPUWmB3jXQWkXwsmJABni0l3As8eFDOudqVxzOplSNUB7QVPRoVjXqwEQ6ixLgo7tz/2q3n6qnEjj2vGd1ihNUbgUMAmzG0wGFuYD7KQa6cULhbpdrH21E30Bm91GW5ZloaJIPyFLssMaB0E5nHJvTyWrlAiwtk+wmaFluGkVnOHz62Z2je/amBdjeaMvDiGlYB1F5h3WplTqY3v7sqdJUFpdUcKN5Hr/GN+YiOXLqnYDUStPbqF/ACi9LCHmKDBdS5yzsSgyCbmiAD2Sckonv3944xO8WRyEgPH4qb9t1eajg98Oc2x0ntdaTG2jqeMkOXmKC106rndw==");
    print(result);
    // var payParams = {};

    // EasyLoading.show();
    // HttpUtil()
    //     .post(getPayInfo, params: payParams)
    //     .onError((ErrorEntity error, stackTrace) {
    //   EasyLoading.showError(error.message!);
    // }).then((value) async {
    //   EasyLoading.dismiss();
    //   if (value == null) return;
    //   value = json.decode(value.toString());
    //   var payInfo = value["data"]["subscriptionCreateAndPay"]
    //       ["paymentStartResult"]["aliPaymentRequest"]["orderStr"];
    //   var result = await tobias.aliPay(payInfo);
    //   print(result);
    //   if (result["resultStatus"].toString() == '9000' ||
    //       result["resultStatus"].toString() == '6001') {
    //     //9000 订单支付成功  6000 用户中途取消
    //     Get.offAllNamed(AppRoutes.orderList);
    //   }
    // });
  }
}
