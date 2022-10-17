import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/api/order/index.dart';
import 'package:rc_china_freshplan_app/common/values/colors.dart';
import 'package:rc_china_freshplan_app/common/widgets/factor.dart';

class OrderUtil {
  static Future getOrders(String text) async {
    var params = {};
    if (text != 'ALL') {
      params['orderState'] = text;
    }
    var data = await OrderEndPoint.getOrders(10, 0, params);
    return data['records'] ?? [];
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
}
