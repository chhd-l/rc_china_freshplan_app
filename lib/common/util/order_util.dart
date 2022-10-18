import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/api/order/index.dart';
import 'package:rc_china_freshplan_app/common/router/app_router.dart';
import 'package:rc_china_freshplan_app/common/values/colors.dart';
import 'package:rc_china_freshplan_app/common/widgets/factor.dart';
import 'package:tobias/tobias.dart' as tobias;

class OrderUtil {
  static Future getOrders(
      int currentPage, String orderState, String nameOrNum) async {
    var params = {};
    if (orderState != 'ALL') {
      params['orderState'] = orderState;
    }
    if (nameOrNum != '') {
      params["queryParameters"] = {"fieldName": "", "fieldValue": nameOrNum};
    }
    var data = await OrderEndPoint.getOrders(currentPage, params);
    return data;
  }

  static Future getOrderDetail(String orderNum) async {
    var data = await OrderEndPoint.getOrderDetail(orderNum);
    if (data == false) {
      return false;
    }
    return data;
  }

  static Future getOrderStatistics() async {
    var data = await OrderEndPoint.getOrderStatistics();
    if (data == false) {
      return false;
    }
    return data;
  }

  static Future completeOrder(String orderNum) async {
    var data = await OrderEndPoint.completeOrder(orderNum);
    if (data == false) {
      return false;
    }
    return data;
  }

  static Future deleteOrder(String orderNum) async {
    var data = await OrderEndPoint.deleteOrder(orderNum);
    if (data == false) {
      return false;
    }
    return data;
  }

  static Future orderContinuePay(order) async {
    var data = await OrderEndPoint.orderContinuePay(order);
    if (data == false) {
      return false;
    }
    return data;
  }

  //催发货
  static toShipTip(context) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text(''),
            content: Column(
              children: [
                Image.asset('assets/images/dialog-tip-icon.png'),
                const SizedBox(height: 24),
                Text(
                  '已提醒发货，请耐心等待',
                  style: textSyle700(color: AppColors.text333),
                )
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    titleButton('确定', () async {
                      Get.back();
                    }, width: 96, height: 30, isCircle: true, fontSize: 12),
                  ],
                ),
              )
            ],
            insetAnimationDuration: const Duration(seconds: 2),
          );
        });
  }

  static orderPay(order) async {
    await orderContinuePay(order).then((value) async {
      if (value == false) return;
      var payInfo = value["aliPaymentRequest"]["orderStr"];
      print(payInfo);
      var result = await tobias.aliPay(payInfo);
      print(result);
      if (result["resultStatus"].toString() == '9000' ||
          result["resultStatus"].toString() == '6001') {
        //9000 订单支付成功  6000 用户中途取消
        Get.offAllNamed(AppRoutes.orderList);
      }
    });
  }
}
