class Consumer {
  String? name;
  String? nickName;
  String? mobile;
  String? storeId;
  List? addresslist;

  Consumer({this.name, this.nickName, this.mobile, this.storeId, this.addresslist});

  Consumer.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    nickName = json['nickName'];
    mobile = json['mobile'];
    storeId = json['storeId'];
    addresslist = json['addresslist'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['nickName'] = this.nickName;
    data['mobile'] = this.mobile;
    data['storeId'] = this.storeId;
    data['addresslist'] = this.addresslist;
    return data;
  }
}
