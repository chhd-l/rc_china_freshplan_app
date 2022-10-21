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

class SubscriptionEndPoint {
  static const String storeId = '39b6444b-683b-4915-8b75-5d8403f40a02';

  static dynamic getSubscriptions() async {
    if (consumer == null) {
      return false;
    }
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

  static dynamic getSubscription(String subscriptionId) async {
    if (consumer == null) {
      return false;
    }
    EasyLoading.show();
    var data = await HttpUtil().post(subscriptionUrl, params: {
      "query": subscriptionGetQuery,
      "variables": {"id": subscriptionId}
    }).onError((ErrorEntity error, stackTrace) {
      EasyLoading.showError(error.message!);
    }).then((value) {
      EasyLoading.dismiss();
      print(value);
      var res = json.decode(value.toString());
      if (res != null && res['data'] != null) {
        return res['data']['subscriptionGet'];
      } else {
        EasyLoading.showError('请求错误');
        return false;
      }
    });
    return data;
  }

  static dynamic cancelSubscription(String subscriptionId) async {
    if (consumer == null) {
      return false;
    }
    EasyLoading.show();
    var data = await HttpUtil().post(subscriptionActionUrl, params: {
      "query": subscriptionCancelMutation,
      "variables": {
        'subscriptionId': subscriptionId,
        'subscriptionType': 'FRESH_PLAN',
        'agreementNo': '',
        'aliPayUserId': '',
        "projectName": 'FRESH_PLAN_ALI_APP'
      }
    }).onError((ErrorEntity error, stackTrace) {
      EasyLoading.showError(error.message!);
    }).then((value) {
      EasyLoading.dismiss();
      print(value);
      var res = json.decode(value.toString());
      if (res != null && res['data'] != null) {
        return res['data']['subscriptionCancel'];
      } else {
        EasyLoading.showError('请求错误');
        return false;
      }
    });
    return data;
  }

  static dynamic updateSubscriptionAddress(
      String subscriptionId, address) async {
    if (consumer == null) {
      return false;
    }
    EasyLoading.show();
    var data = await HttpUtil().post(subscriptionActionUrl, params: {
      "query": subscriptionUpdateAddressMutation,
      "variables": {
        'id': subscriptionId,
        'address': address,
      }
    }).onError((ErrorEntity error, stackTrace) {
      EasyLoading.showError(error.message!);
    }).then((value) {
      EasyLoading.dismiss();
      print(value);
      var res = json.decode(value.toString());
      if (res != null && res['data'] != null) {
        return res['data']['subscriptionUpdateAddress'];
      } else {
        EasyLoading.showError('请求错误');
        return false;
      }
    });
    return data;
  }
}
