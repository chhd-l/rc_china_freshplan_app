class Consumer {
  String? name;
  String? nickName;
  String? mobile;
  String? storeId;

  Consumer({this.name, this.nickName, this.mobile, this.storeId});

  Consumer.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    nickName = json['nickName'];
    mobile = json['mobile'];
    storeId = json['storeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['nickName'] = this.nickName;
    data['mobile'] = this.mobile;
    data['storeId'] = this.storeId;
    return data;
  }
}
