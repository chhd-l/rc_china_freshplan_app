import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/common/util/event_bus.dart';

import 'package:rc_china_freshplan_app/common/util/subscription_util.dart';
import 'package:rc_china_freshplan_app/common/values/const.dart';
import 'package:rc_china_freshplan_app/global.dart';

import 'state.dart';

class SubscriptionDetailLogic extends GetxController {
  final state = SubscriptionDetailState();

  Rx<Map> subscriptionDetail = Rx<Map>({});

  final global = Get.put(GlobalConfigService());

  String subscriptionId=Get.arguments ?? '';

  @override
  void onReady() {
    getSubscriptionDetail();

    EventBus().addListener(cancelSubscription, (arg) {
      getSubscriptionDetail();
    });

    super.onReady();
  }

  getSubscriptionDetail() async {
    await SubscriptionUtil.getSubscription(subscriptionId).then((value) {
      if (value != false) {
        subscriptionDetail.value = value;
      }
    });
  }
}
