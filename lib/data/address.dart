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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['receiverName'] = this.receiverName;
    data['phone'] = this.phone;
    data['province'] = this.province;
    data['city'] = this.city;
    data['region'] = this.region;
    data['detail'] = this.detail;
    data['isDefault'] = this.isDefault;
    return data;
  }
}