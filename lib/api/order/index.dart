import 'package:rc_china_freshplan_app/common/util/http.dart';
import 'package:rc_china_freshplan_app/common/values/api_path.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'query.dart';
import 'dart:convert';
import 'package:rc_china_freshplan_app/common/util/storage.dart';
import 'package:rc_china_freshplan_app/data/consumer.dart';

Consumer? consumer = StorageUtil().getJSON("loginUser") != null
    ? Consumer.fromJson(StorageUtil().getJSON("loginUser"))
    : null;

class OrderEndPoint {
  static const String storeId = '39b6444b-683b-4915-8b75-5d8403f40a02';

  static dynamic getOrders(limit, offset, sample) async {
    if (consumer == null) {
      return false;
    }
    EasyLoading.show();
    var data = await HttpUtil().post(orderUrl, params: {
      "query": orderListQuery,
      "variables": {
        "input": {
          "sample": {
            ...sample,
            "consumerId": consumer?.id,
          },
          'withTotal': true,
          "limit": limit,
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
}
