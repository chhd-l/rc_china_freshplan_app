class Consumer {
  String? name;
  String? nickName;
  String? mobile;
  String? storeId;
  String? avatarUrl;
  List? addresslist;

  Consumer(
      {this.name,
      this.nickName,
      this.mobile,
      this.storeId,
      this.avatarUrl,
      this.addresslist});

  Consumer.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    nickName = json['nickName'];
    mobile = json['mobile'];
    storeId = json['storeId'];
    avatarUrl = json['avatarUrl'];
    addresslist = json['addresslist'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['nickName'] = this.nickName;
    data['mobile'] = this.mobile;
    data['storeId'] = this.storeId;
    data['avatarUrl'] = this.avatarUrl;
    data['addresslist'] = this.addresslist;
    return data;
  }
}
