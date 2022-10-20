import 'package:rc_china_freshplan_app/api/subscription/index.dart';
import 'package:rc_china_freshplan_app/common/util/event_bus.dart';
import 'package:rc_china_freshplan_app/common/util/utils.dart';

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
    showTipAlertDialog(context, '您确定要取消这个计划吗？', () async {
      await cancelSubscription(subscriptionId).then((value) {
        if (value == true) {
          EventBus().sendBroadcast(cancelSubscription);
        }
      });
    });
  }
}
