import 'package:rc_china_freshplan_app/api/order/index.dart';
import 'package:rc_china_freshplan_app/common/util/event_bus.dart';
import 'package:rc_china_freshplan_app/common/util/utils.dart';
import 'package:rc_china_freshplan_app/common/values/const.dart';
import 'package:tobias/tobias.dart' as tobias;

class OrderUtil {
  static Future getOrders(
      int currentPage, String orderState, String nameOrNum) async {
    var params = {};
    if (orderState != 'ALL') {
      params['orderState'] = orderState;
    }
    if (nameOrNum != '') {
      params["queryParameters"] = {
        "fieldName": "orderNoOrProductName",
        "fieldValue": nameOrNum
      };
    }
    var data = await OrderEndPoint.getOrders(currentPage, params);
    return data;
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

  static Future cancelOrder(String orderNum) async {
    var data = await OrderEndPoint.cancelOrder(orderNum);
    if (data == false) {
      return false;
    }
    if (data) {
      EventBus().sendBroadcast(updateOrder);
    }
    return data;
  }

  static Future completeOrder(String orderNum) async {
    var data = await OrderEndPoint.completeOrder(orderNum);
    if (data == false) {
      return false;
    }
    if (data) {
      EventBus().sendBroadcast(updateOrder);
    }
    return data;
  }

  static Future deleteOrder(String orderNum) async {
    var data = await OrderEndPoint.deleteOrder(orderNum);
    if (data == false) {
      return false;
    }
    if (data) {
      EventBus().sendBroadcast(updateOrder);
    }
    return data;
  }

  static Future orderContinuePay(order) async {
    var data = await OrderEndPoint.orderContinuePay(order);
    if (data == false) {
      return false;
    }
    return data;
  }

  //?????????
  static toShipTip(context) {
    showTipAlertDialog(context, '?????????????????????????????????', () {}, needCancelBtn: false);
  }

  static orderPay(order) async {
    await orderContinuePay(order).then((value) async {
      if (value == false) return;
      var payInfo = value["aliPaymentRequest"]["orderStr"];
      var result = await tobias.aliPay(payInfo);
      print(result);
      if (result["resultStatus"].toString() == '9000' ||
          result["resultStatus"].toString() == '6001') {
        //9000 ??????????????????  6000 ??????????????????
        EventBus().sendBroadcast(updateOrder);
      }
    });
  }

  static Future getExpressCompany() async {
    var data = await OrderEndPoint.getExpressCompany();
    if (data == false) {
      return [];
    }
    return data ?? [];
  }
}
