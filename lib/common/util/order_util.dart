import 'package:rc_china_freshplan_app/api/order/index.dart';
import 'package:rc_china_freshplan_app/data/order.dart';

class OrderUtil {
  static List orderLists= [];

  static Future getOrders(String text) async {
    print('getOrders');
    print(text);
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

  static Future getOrderDetail(String orderNum) async {
    var data = await OrderEndPoint.getOrderDetail(orderNum);
    if (data == false) {
      return false;
    }
    return data;
  }
}
