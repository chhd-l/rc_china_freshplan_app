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
        "app_id=2021003147642386&auth_type=AUTHACCOUNT&method=alipay.open.auth.sdk.code.get&pid=2088702440004003&product_id=APP_FAST_LOGIN&scope=auth_user&target_id=test0001&apiname=com.alipay.account.auth&biz_type=openservice&sign_type=RSA2&app_name=mc&sign=b5r9QdsgvCPFjBBWRASypzL58SmIaJ2n1aQtlbiHHOBjQ6CNBafftiBymPnlgSKKMNULiBBWg73Fq5ESNQnVqn1ED/7knHi8AG9uUd06FT+GxJZzVXj1ci6JJpzS7V9HAtOeDGTlMSGZj4kRrtOek0DpMl0CEDLn0SmpH6fT9etYb5Y3AOKSet50XjCde+29+scaicU4grv08xNY47IhLx2xcNglgZMxXGTMBMWVzqKe2nxmJDGaezjrsDFVbxwP6UEWWWSXd8EciygAgIs1+JKvoJRrxCCHaHLijsauctj2aCmzHKPEuLXQIk3S07QirA8X8Sa9JvabGx+zlel+3w==");
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
