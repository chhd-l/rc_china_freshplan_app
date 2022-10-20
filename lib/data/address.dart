class AddRess {
  String? id;
  String? receiverName;
  String? phone;
  String? province;
  String? city;
  String? region;
  String? detail;
  bool? isDefault;

  AddRess({
    this.id,
      this.receiverName,
      this.phone,
      this.province,
      this.city,
      this.region,
      this.detail,
      this.isDefault
    });

  AddRess.fromJson(Map<String, dynamic> json) {
    receiverName = json['receiverName'];
    id = json['id'];
    phone = json['phone'];
    province = json['province'];
    city = json['city'];
    region = json['region'];
    detail = json['detail'];
    isDefault = json['isDefault'];
  }

  
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['receiverName'] = receiverName;
    data['phone'] = phone;
    data['province'] = province;
    data['city'] = city;
    data['region'] = region;
    data['detail'] = detail;
    data['isDefault'] = isDefault;
    return data;
  }

  Map<String, dynamic> clonePayAddressToJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['receiverName'] = receiverName;
    data['phone'] = phone;
    data['province'] = province;
    data['city'] = city;
    data['region'] = region;
    data['detail'] = detail;
    return data;
  }
}