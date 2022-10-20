import 'package:rc_china_freshplan_app/data/address.dart';
import 'package:rc_china_freshplan_app/data/consumer.dart';
import 'package:rc_china_freshplan_app/common/util/storage.dart';
import 'package:rc_china_freshplan_app/api/address/index.dart';

class AddRessUtil {
  static List<AddRess> addRessList = [];
  static late Consumer? consumer;

  static AddRess normalizeFromApi(dynamic data) {
    return AddRess(
      id: data['id'],
      receiverName: data['receiverName'],
      phone: data['phone'],
      province: data['province'],
      city: data['city'],
      region: data['region'],
      detail: data['detail'],
      isDefault: data['isDefault'],
    );
  }

  static Map<String, dynamic> normalizeToApi(AddRess address, String consumerId,
      {bool needId = false}) {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (needId) {
      data['id'] = address.id;
    }
    data['consumerId'] = consumerId;
    data['receiverName'] = address.receiverName;
    data['phone'] = address.phone;
    data['province'] = address.province;
    data['city'] = address.city;
    data['region'] = address.region;
    data['detail'] = address.detail;
    data['isDefault'] = address.isDefault;
    return data;
  }

  static Future<List<AddRess>> getAddressList() async {
    var list = await AddressEndPoint.getAddressList();
    addRessList = list;
    return list;
  }

  static Future<void> init() async {
    consumer = StorageUtil().getJSON("loginUser") != null
        ? Consumer.fromJson(StorageUtil().getJSON("loginUser"))
        : null;
    if (consumer != null) {
      var petListInStorage =
          StorageUtil().getJSON('${consumer?.addresslist}_addRess');
      if (petListInStorage != null) {
        List<dynamic> list = List.from(petListInStorage);
        addRessList = List<AddRess>.from(list.map((e) => AddRess.fromJson(e)));
      }
    }
  }

  static void logout() {
    addRessList.clear();
  }

  static Future addRes(AddRess address) {
    return AddressEndPoint.createAddress(address);
  }

  static AddRess getAddRess(String id) {
    var init = addRessList.singleWhere((element) => element.id == id,
        orElse: () => AddRess(
              id: '-1',
              receiverName: '',
              phone: '',
              region: '',
              city: '',
              detail: '',
              isDefault: false,
              province: '',
            ));
    return init;
  }

  static Future<bool> updateAddRess(AddRess address) {
    return AddressEndPoint.updateAddress(address);
  }

  static Future<bool> removeAddRess(String id) {
    return AddressEndPoint.deleteAddress(id);
  }

  static void removeAllAddRess() {
    addRessList.clear();
    StorageUtil().remove('${consumer?.phone}_addRess');
  }
}
