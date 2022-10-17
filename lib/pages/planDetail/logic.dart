import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/common/util/subscription_util.dart';
import 'package:rc_china_freshplan_app/global.dart';

import 'state.dart';

class PlanDetailLogic extends GetxController {
  final state = PlanDetailState();

  var planDetail = {};

  final global = Get.put(GlobalConfigService());

  @override
  void onReady() {
    getSubscriptionDetail();
    super.onReady();
  }

  getSubscriptionDetail() async {
    var subscriptionId = Get.arguments ?? '';
    await SubscriptionUtil.getSubscription(subscriptionId).then((value) {
      print(2222);
      print(value);
      if (value != false) {
        planDetail = value;
      }
    });
  }
}
