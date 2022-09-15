import 'package:rc_china_freshplan_app/common/util/http.dart';
import 'package:rc_china_freshplan_app/common/values/api_path.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:rc_china_freshplan_app/common/util/storage.dart';
import 'query.dart';
import 'dart:convert';

class ConsumerEndPoint {
  static const String storeId = '39b6444b-683b-4915-8b75-5d8403f40a02';

  static String getLoggedConsumerId() {
    var loggedUser = StorageUtil().getJSON("loginUser");
    if (loggedUser != null) {
      return loggedUser['id'];
    } else {
      return '';
    }
  }

  static dynamic appLogin(String phone) async {
    EasyLoading.show(status: 'loading...');
    var data = await HttpUtil().post(wxAuthUrl, params: {
      "query": appLoginQuery,
      "variables": {
        "phone": phone,
        "storeId": storeId,
      }
    }).onError((ErrorEntity error, stackTrace) {
      EasyLoading.showError(error.message!);
    }).then((value) {
      EasyLoading.dismiss();
      var res = json.decode(value.toString());
      if (res['data'] != null && res['data']['appLogin'] != null) {
        return res['data']['appLogin'];
      } else {
        EasyLoading.showError('用户名或密码错误');
        return false;
      }
    });
    return data;
  }

  static dynamic changeToken() async {
    var token = StorageUtil().getStr('accessToken');
    if (token == '') {
      return false;
    }
    HttpUtil().post(wxAuthUrl, params: {
      "query": changeTokenQuery,
      "variables": {
        "token": token,
      }
    }).then((value) {
      var newToken = json.decode(value.toString())['data']['wxLogin'];
      StorageUtil().setStr("accessToken", newToken['access_token']);
    });
  }
}
