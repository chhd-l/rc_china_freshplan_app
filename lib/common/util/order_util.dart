import 'package:rc_china_freshplan_app/api/order/index.dart';

class OrderUtil {
  static List orderLists= [];

  static void getOrders() async {
    print('getorders');
    var params = {};
    var data = await OrderEndPoint.getOrders(10, 0, params);
    if (data != false) {
      orderLists = data['records'];
    }
  }
}
