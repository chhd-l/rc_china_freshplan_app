import 'package:rc_china_freshplan_app/api/order/index.dart';

class OrderUtil {
  static Future getOrders(String text) async {
    var params = {};
    if (text != 'ALL') {
      params['orderState'] = text;
    }
    var data = await OrderEndPoint.getOrders(10, 0, params);
    return data['records'] ?? [];
  }

  static Future getOrderDetail(String orderNum) async {
    var data = await OrderEndPoint.getOrderDetail(orderNum);
    if (data == false) {
      return false;
    }
    return data;
  }

  static Future getOrderStatistics() async {
    var data = await OrderEndPoint.getOrderStatistics();
    if (data == false) {
      return false;
    }
    return data;
  }

  static Future completeOrder(String orderNum) async {
    var data = await OrderEndPoint.completeOrder(orderNum);
    if (data == false) {
      return false;
    }
    return data;
  }

  static Future deleteOrder(String orderNum) async {
    var data = await OrderEndPoint.deleteOrder(orderNum);
    if (data == false) {
      return false;
    }
    return data;
  }
}
