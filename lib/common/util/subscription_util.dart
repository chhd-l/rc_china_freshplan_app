import 'package:rc_china_freshplan_app/api/subscription/index.dart';

class SubscriptionUtil {
  static Future getSubscriptions() async {
    var data = await SubscriptionEndPoint.getSubscriptions();
    return data ?? [];
  }
}
