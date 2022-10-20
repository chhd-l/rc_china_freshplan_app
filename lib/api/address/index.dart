import 'package:rc_china_freshplan_app/common/util/http.dart';
import 'package:rc_china_freshplan_app/common/util/address_util.dart';
import 'package:rc_china_freshplan_app/common/values/api_path.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:rc_china_freshplan_app/api/consumer/index.dart';
import 'package:rc_china_freshplan_app/data/address.dart';
import 'query.dart';
import 'dart:convert';

class AddressEndPoint {
  static Future<List<AddRess>> getAddressList() async {
    String consumerId = ConsumerEndPoint.getLoggedConsumerId();
    EasyLoading.show();
    return await HttpUtil().post(addressUrl, params: {
      "query": getAddressListQuery,
      "variables": {
        "consumerId": consumerId,
      }
    }).then((value) {
      EasyLoading.dismiss();
      var db = json.decode(value.toString())?['data']?['consumerAddressFind'];
      if (db != null) {
        return List<AddRess>.from(
            List.from(db).map((e) => AddRessUtil.normalizeFromApi(e)));
      } else {
        return [];
      }
    });
  }

  static Future createAddress(AddRess address) async {
    String consumerId = ConsumerEndPoint.getLoggedConsumerId();
    EasyLoading.show();
    return await HttpUtil().post(addressActionUrl, params: {
      "query": createAddressMutation,
      "variables": {
        "input": AddRessUtil.normalizeToApi(address, consumerId),
      }
    }).then((value) {
      EasyLoading.dismiss();
      var db = json.decode(value.toString())?['data']?['consumerAddressCreate'];
      if (db != null) {
        return db['id'];
      } else {
        return false;
      }
    });
  }

  static Future<bool> updateAddress(AddRess address) async {
    String consumerId = ConsumerEndPoint.getLoggedConsumerId();
    EasyLoading.show();
    return await HttpUtil().post(addressActionUrl, params: {
      "query": updateAddressMutation,
      "variables": {
        "input": AddRessUtil.normalizeToApi(address, consumerId, needId: true),
      }
    }).then((value) {
      EasyLoading.dismiss();
      var db = json.decode(value.toString())?['data']?['consumerAddressUpdate'];
      return db ?? false;
    });
  }

  static Future<bool> deleteAddress(String addressId) async {
    EasyLoading.show();
    return await HttpUtil().post(addressActionUrl, params: {
      "query": deleteAddressMutation,
      "variables": {
        "id": addressId,
      }
    }).then((value) {
      EasyLoading.dismiss();
      var db = json.decode(value.toString())?['data']?['consumerAddressDelete'];
      return db ?? false;
    });
  }
}
