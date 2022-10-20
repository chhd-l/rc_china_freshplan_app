import 'package:rc_china_freshplan_app/common/util/storage.dart';

class Consumer {
  String? id;
  String? name;
  String? gender;
  String? nickName;
  String? email;
  String? phone;
  String? level;
  int? points;
  String? defaultConsumerAddressId;
  String? lastLoginTime;
  String? storeId;
  String? avatarUrl;
  List? addresslist;

  Consumer(
      {this.id,
      this.name,
      this.gender,
      this.nickName,
      this.email,
      this.phone,
      this.level,
      this.points,
      this.defaultConsumerAddressId,
      this.lastLoginTime,
      this.storeId,
      this.avatarUrl,
      this.addresslist});

  Consumer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    gender = json['gender'];
    nickName = json['nickName'];
    email = json['email'];
    phone = json['phone'];
    level = json['level'];
    points = json['points'];
    defaultConsumerAddressId = json['defaultConsumerAddressId'];
    lastLoginTime = json['lastLoginTime'];
    storeId = json['storeId'];
    avatarUrl = json['avatarUrl'];
    addresslist = json['addresslist'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['gender'] = gender;
    data['nickName'] = nickName;
    data['email'] = email;
    data['phone'] = phone;
    data['level'] = level;
    data['points'] = points;
    data['defaultConsumerAddressId'] = defaultConsumerAddressId;
    data['lastLoginTime'] = lastLoginTime;
    data['storeId'] = storeId;
    data['avatarUrl'] = avatarUrl;
    data['addresslist'] = addresslist;
    return data;
  }

  Map<String, dynamic> payConsumerAccountToJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    var consumerAccount=StorageUtil().getJSON('consumerAccount');
    data['unionId'] = consumerAccount["unionId"];
    data['openId'] = consumerAccount["openId"];
    data['isWXGroupVip'] = consumerAccount["isWXGroupVip"];
    return data;
  }

  Map<String, dynamic> payConsumerToJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['nickName'] = nickName;
    data['email'] = email;
    data['phone'] = phone;
    data['level'] = level;
    data['points'] = points;
    data['avatarUrl'] = avatarUrl;
    data['account']=payConsumerAccountToJson();
    return data;
  }
}
