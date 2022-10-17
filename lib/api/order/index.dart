import 'package:rc_china_freshplan_app/common/util/http.dart';
import 'package:rc_china_freshplan_app/common/values/api_path.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../consumer/index.dart';
import 'query.dart';
import 'dart:convert';
import 'package:rc_china_freshplan_app/common/util/storage.dart';
import 'package:rc_china_freshplan_app/data/consumer.dart';

Consumer? consumer = StorageUtil().getJSON("loginUser") != null
    ? Consumer.fromJson(StorageUtil().getJSON("loginUser"))
    : null;

class OrderEndPoint {
  static const String storeId = '39b6444b-683b-4915-8b75-5d8403f40a02';

  static dynamic getOrders(offset, sample) async {
    if (consumer == null) {
      return false;
    }
    String consumerId = ConsumerEndPoint.getLoggedConsumerId();
    EasyLoading.show();
    var data = await HttpUtil().post(orderUrl, params: {
      "query": orderListQuery,
      "variables": {
        "input": {
          "sample": {...sample, "consumerId": consumerId},
          'withTotal': true,
          "limit": 10,
          "offset": offset,
          "storeId": consumer?.storeId,
        }
      }
    }).onError((ErrorEntity error, stackTrace) {
      EasyLoading.showError(error.message!);
    }).then((value) {
      EasyLoading.dismiss();
      var res = json.decode(value.toString());
      if (res['data'] != null) {
        return res['data']['orderFindPage'];
      } else {
        EasyLoading.showError('请求错误');
        return false;
      }
    });
    return data;
  }

  static dynamic getOrderDetail(String orderNum) async {
    if (consumer == null) {
      return false;
    }
    EasyLoading.show();
    var data = await HttpUtil().post(orderDetailUrl, params: {
      "query": orderDetailQuery,
      "variables": {
        "input": {
          "storeId": consumer?.storeId,
          "orderNum": orderNum,
        }
      }
    }).onError((ErrorEntity error, stackTrace) {
      EasyLoading.showError(error.message!);
    }).then((value) {
      EasyLoading.dismiss();
      var res = json.decode(value.toString());
      if (res['data']['orderGet'] != null) {
        return res['data']['orderGet'];
      } else {
        EasyLoading.showError('请求错误');
        return false;
      }
    });
    return data;
  }

  static dynamic getOrderStatistics() async {
    if (consumer == null) {
      return false;
    }
    EasyLoading.show();
    var data = await HttpUtil().post(orderStatisticsUrl, params: {
      "query": orderStatisticsQuery,
      "variables": {}
    }).onError((ErrorEntity error, stackTrace) {
      EasyLoading.showError(error.message!);
    }).then((value) {
      EasyLoading.dismiss();
      var res = json.decode(value.toString());
      if (res['data']['OrderStatistics'] != null) {
        return res['data']['OrderStatistics'];
      } else {
        EasyLoading.showError('请求错误');
        return false;
      }
    });
    return data;
  }

  static dynamic cancelOrder(String orderNum) async {
    if (consumer == null) {
      return false;
    }
    EasyLoading.show();
    var data = await HttpUtil().post(orderActionUrl, params: {
      "query": orderCancelMutation,
      "variables": {
        "input": {"orderNum": orderNum, "nowOrderState": "UNPAID"}
      }
    }).onError((ErrorEntity error, stackTrace) {
      EasyLoading.showError(error.message!);
    }).then((value) {
      EasyLoading.dismiss();
      var res = json.decode(value.toString());
      if (res['data']['orderCancel'] != null) {
        EasyLoading.showSuccess('操作成功');
        return res['data']['orderCancel'];
      } else {
        EasyLoading.showError('请求错误');
        return false;
      }
    });
    return data;
  }

  static dynamic completeOrder(String orderNum) async {
    if (consumer == null) {
      return false;
    }
    EasyLoading.show();
    var data = await HttpUtil().post(orderActionUrl, params: {
      "query": orderCompletedMutation,
      "variables": {
        "input": {
          "orderNum": orderNum,
          "nowOrderState": "SHIPPED",
          "storeId": consumer?.storeId,
        }
      }
    }).onError((ErrorEntity error, stackTrace) {
      EasyLoading.showError(error.message!);
    }).then((value) {
      EasyLoading.dismiss();
      var res = json.decode(value.toString());
      if (res['data']['orderCompleted'] != null) {
        EasyLoading.showSuccess('操作成功');
        return res['data']['orderCompleted'];
      } else {
        EasyLoading.showError('请求错误');
        return false;
      }
    });
    return data;
  }

  static dynamic deleteOrder(String orderNum) async {
    if (consumer == null) {
      return false;
    }
    String consumerId = ConsumerEndPoint.getLoggedConsumerId();
    EasyLoading.show();
    var data = await HttpUtil().post(orderActionUrl, params: {
      "query": orderDeleteMutation,
      "variables": {
        "input": {
          "orderNum": orderNum,
          "storeId": consumer?.storeId,
          "consumerId": consumerId
        }
      }
    }).onError((ErrorEntity error, stackTrace) {
      EasyLoading.showError(error.message!);
    }).then((value) {
      EasyLoading.dismiss();
      var res = json.decode(value.toString());
      if (res['data']['deleteOrder'] != null) {
        EasyLoading.showSuccess('操作成功');
        return res['data']['deleteOrder'];
      } else {
        EasyLoading.showError('请求错误');
        return false;
      }
    });
    return data;
  }

  //继续支付
  static dynamic orderContinuePay(order) async {
    if (consumer == null) {
      return false;
    }
    EasyLoading.show();
    var data = await HttpUtil().post(paymentUrl, params: {
      "query": paymentStartMutation,
      "variables": {
        "input": {
          "consumerId": order["consumer"]["consumerId"],
          "consumerOpenId": order["consumer"]["openId"],
          "orderId": order["_id"],
          "orderNo": order["orderNumber"],
          "orderDescription": '订单支付',
          "payWayId": 'ALI_PAY_APP',
          "amount": order["orderPrice"]["totalPrice"] * 100,
          "currency": 'CNY',
          "storeId": storeId,
        }
      }
    }).onError((ErrorEntity error, stackTrace) {
      EasyLoading.showError(error.message!);
    }).then((value) {
      EasyLoading.dismiss();
      var res = json.decode(value.toString());
      if (res['data']['paymentStart'] != null) {
        return res['data']['paymentStart'];
      } else {
        EasyLoading.showError('请求错误');
        return false;
      }
    });
    return data;
  }
}
