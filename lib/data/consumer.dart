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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['nickName'] = this.nickName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['level'] = this.level;
    data['points'] = this.points;
    data['defaultConsumerAddressId'] = this.defaultConsumerAddressId;
    data['lastLoginTime'] = this.lastLoginTime;
    data['storeId'] = this.storeId;
    data['avatarUrl'] = this.avatarUrl;
    data['addresslist'] = this.addresslist;
    return data;
  }
}
