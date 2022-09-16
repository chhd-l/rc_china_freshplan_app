import 'package:rc_china_freshplan_app/api/order/index.dart';
import 'package:rc_china_freshplan_app/data/order.dart';

class OrderUtil {
  static List orderLists= [];

  static Future<List<Order>> getOrders(String text) async {
    var params = {};
    if(text != 'ALL') {
      params['orderState'] = text;
    }
    var data = await OrderEndPoint.getOrders(10, 0, params);
    if (data != false) {
      orderLists = data['records'];
    }
    return data['records'];
  }
}
