import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/common/util/event_bus.dart';
import 'package:rc_china_freshplan_app/common/util/subscription_util.dart';
import 'package:rc_china_freshplan_app/common/values/const.dart';
import 'package:rc_china_freshplan_app/global.dart';

import 'state.dart';

class PlanDetailLogic extends GetxController {
  final state = PlanDetailState();

  Rx<Map> planDetail = Rx<Map>({});

  final global = Get.put(GlobalConfigService());

  final subscriptionId = Get.arguments ?? '';

  @override
  void onReady() {
    getSubscriptionDetail();
    EventBus().addListener(updateSubscription, (arg) {
      getSubscriptionDetail();
    });
    super.onReady();
  }

  getSubscriptionDetail() async {
    await SubscriptionUtil.getSubscription(subscriptionId).then((value) {
      if (value != false) {
        planDetail.value = value;
      }
    });
  }
}
