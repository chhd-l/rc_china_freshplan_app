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

  static dynamic appLogin(String phone, String password) async {
    EasyLoading.show();
    var data = await HttpUtil().post(wxAuthUrl, params: {
      "query": appLoginQuery,
      "variables": {
        "input": {
          "jsCode": password,
          "storeId": storeId,
          "authType": "PHONE",
          "phoneCode": phone
        },
        "updateConsumerFiled": {
          "avatarUrl": "",
          "nickName": "",
          "gender": "",
        },
        "operator": ""
      }
    }).onError((ErrorEntity error, stackTrace) {
      EasyLoading.showError(error.message!);
    }).then((value) {
      EasyLoading.dismiss();
      var res = json.decode(value.toString());
      if (res['data'] != null && res['data']['allAuth'] != null) {
        return res['data']['allAuth'];
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

  static void sendVerificationCode(String phone, String codeType) async {
    await HttpUtil().post(wxAuthUrl, params: {
      "query": sendCodeMutation,
      "variables": {
        "input": {
          "sendType": "PHONE_VERIFICATION_CODE",
          "receivingSubject": phone,
          "verificationCodeType": codeType,
          "storeId": storeId
        }
      }
    });
  }

  static dynamic registerByPhone(
      String phone, String vcode, String password) async {
    EasyLoading.show();
    var data = await HttpUtil().post(wxAuthUrl, params: {
      "query": registerMutation,
      "variables": {
        "input": {
          "registerType": "PHONE_REGISTRATION",
          "consumerInfo": {"phone": phone, "storeId": storeId},
          "registerCode": vcode,
          "password": password
        }
      }
    }).then((value) {
      EasyLoading.dismiss();
      var db = json.decode(value.toString());
      if (db['data'] != null && db['data']['consumerRegister'] != null) {
        return db['data']['consumerRegister'];
      } else {
        return false;
      }
    });
    return data;
  }

  static dynamic checkVerificationCode(
      String phone, String code, String codeType) async {
    EasyLoading.show();
    var data = await HttpUtil().post(wxAuthUrl, params: {
      "query": checkCodeMutation,
      "variables": {
        "input": {
          "sendType": "PHONE_VERIFICATION_CODE",
          "receivingSubject": phone,
          "verificationCodeType": codeType,
          "verificationCode": code,
          "storeId": storeId
        }
      }
    }).then((value) {
      EasyLoading.dismiss();
      var db = json.decode(value.toString());
      if (db['data'] != null && db['data']['checkVerificationCode'] != null) {
        return db['data']['checkVerificationCode'];
      } else {
        return false;
      }
    });
    return data;
  }

  static dynamic resetPassword(
      String phone, String code, String password) async {
    EasyLoading.show();
    var data = await HttpUtil().post(wxAuthUrl, params: {
      "query": changePasswordMutation,
      "variables": {
        "input": {
          "changeMethodType": "PHONE_CHANGE_METHOD",
          "changeSubject": phone,
          "password": password,
          "verificationCode": code,
          "storeId": storeId
        }
      }
    }).then((value) {
      EasyLoading.dismiss();
      var db = json.decode(value.toString());
      if (db['data'] != null && db['data']['consumerChangePassword'] != null) {
        return db['data']['consumerChangePassword'];
      } else {
        return false;
      }
    });
    return data;
  }
}
