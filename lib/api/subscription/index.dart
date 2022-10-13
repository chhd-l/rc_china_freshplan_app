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

class SubscriptionEndPoint {
  static const String storeId = '39b6444b-683b-4915-8b75-5d8403f40a02';

  static dynamic getSubscriptions() async {
    if (consumer == null) {
      return false;
    }
    String consumerId = ConsumerEndPoint.getLoggedConsumerId();
    EasyLoading.show();
    var data = await HttpUtil().post(subscriptionListUrl, params: {
      "query": subscriptionFindByConsumerIdQuery,
      "variables": {}
    }).onError((ErrorEntity error, stackTrace) {
      EasyLoading.showError(error.message!);
    }).then((value) {
      EasyLoading.dismiss();
      print(value);
      var res = json.decode(value.toString());
      if (res != null && res['data'] != null) {
        return res['data']['subscriptionFindByConsumerId'];
      } else {
        EasyLoading.showError('请求错误');
        return [];
      }
    });
    return data;
  }
}
