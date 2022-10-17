import 'package:get/get.dart';

import 'package:rc_china_freshplan_app/common/util/subscription_util.dart';
import 'package:rc_china_freshplan_app/global.dart';

import 'state.dart';

class SubscriptionDetailLogic extends GetxController {
  final state = SubscriptionDetailState();

  Rx<Map> subscriptionDetail=Rx<Map>({});

  final global = Get.put(GlobalConfigService());

  @override
  void onReady() {
    getSubscriptionDetail();
    super.onReady();
  }

  getSubscriptionDetail() async {
    print('dddddd');
    print(Get.arguments);
    var subscriptionId = Get.arguments ?? '';
    await SubscriptionUtil.getSubscription(subscriptionId).then((value) {
      print(2222);
      print(value);
      if (value != false) {
        subscriptionDetail.value = value;
      }
    });
  }
}
