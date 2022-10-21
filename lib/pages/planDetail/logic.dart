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
    EventBus().addListener(cancelSubscription, (arg) {
      getSubscriptionDetail();
    });
    EventBus().addListener(updatePlanAddress, (arg) {
      updateSubscriptionAddress();
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

  updateSubscriptionAddress() async {
    print(111);
    print(global.planDetailAddress.value);
    print(global.planDetailAddress.value.toJson());
    print(2222);
    print(global.planDetailAddress.value.clonePayAddressToJson());
    await SubscriptionUtil.updateSubscriptionAddress(subscriptionId,
            global.planDetailAddress.value.clonePayAddressToJson())
        .then((value) {
      if (value != false) {
        getSubscriptionDetail();
      }
    });
  }
}
