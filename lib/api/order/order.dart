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

  static dynamic appLogin(sample) async {
    if(consumer == null) {
      return false;
    }
    EasyLoading.show(status: 'loading...');
    var data = await HttpUtil().post(wxAuthUrl, params: {
      "query": orderListQuery,
      "variables": {
        "sample": sample,
        "storeId": storeId,
        "consumerId": consumer,
      }
    }).onError((ErrorEntity error, stackTrace) {
      EasyLoading.showError(error.message!);
    }).then((value) {
      EasyLoading.dismiss();
      var res = json.decode(value.toString());
      if (res['data'] != null && res['data']['appLogin'] != null) {
        return res['data']['appLogin'];
      } else {
        EasyLoading.showError('请求错误');
        return false;
      }
    });
    return data;
  }
}
