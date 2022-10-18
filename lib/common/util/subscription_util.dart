import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/api/subscription/index.dart';
import 'package:rc_china_freshplan_app/common/util/event_bus.dart';
import 'package:rc_china_freshplan_app/common/values/colors.dart';
import 'package:rc_china_freshplan_app/common/values/const.dart';
import 'package:rc_china_freshplan_app/common/widgets/factor.dart';

class SubscriptionUtil {
  static Future getSubscriptions() async {
    var data = await SubscriptionEndPoint.getSubscriptions();
    return data ?? [];
  }

  static Future getSubscription(String subscriptionId) async {
    var data = await SubscriptionEndPoint.getSubscription(subscriptionId);
    return data ?? [];
  }

  static Future cancelSubscription(String subscriptionId) async {
    var data = await SubscriptionEndPoint.cancelSubscription(subscriptionId);
    return data ?? false;
  }

  static Future updateSubscriptionAddress(
      String subscriptionId, address) async {
    var data = await SubscriptionEndPoint.updateSubscriptionAddress(
        subscriptionId, address);
    return data ?? false;
  }

  static cancelSubAction(context, subscriptionId) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text(''),
            content: Column(
              children: [
                Image.asset('assets/images/dialog-tip-icon.png'),
                const SizedBox(height: 24),
                Text('您确定要取消这个计划吗？',
                    style: textSyle700(color: AppColors.text333))
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    titleButton('确定', () async {
                      await cancelSubscription(subscriptionId).then((value){
                        if(value==true){
                          EventBus().sendBroadcast(cancelSubscription);
                        }
                      });
                      Get.back();
                    },
                        width: 96,
                        height: 30,
                        isCircle: true,
                        bgColor: const Color.fromRGBO(200, 227, 153, 1),
                        fontSize: 12),
                    titleButton('我在想想', () {
                      Get.back();
                    }, width: 112, height: 30, isCircle: true, fontSize: 12),
                  ],
                ),
              )
            ],
            insetAnimationDuration: const Duration(seconds: 2),
          );
        });
  }
}
