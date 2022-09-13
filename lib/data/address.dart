class AddRess {
  String? receiverName;
  String? phone;
  String? province;
  String? city;
  String? region;
  String? detail;
  bool? isDefault;

  AddRess(
      {this.receiverName,
      this.phone,
      this.province,
      this.city,
      this.region,
      this.detail,
      this.isDefault});

  AddRess.fromJson(Map<String, dynamic> json) {
    receiverName = json['receiverName'];
    phone = json['phone'];
    province = json['province'];
    city = json['city'];
    region = json['region'];
    detail = json['detail'];
    isDefault = json['isDefault'];
  }
}