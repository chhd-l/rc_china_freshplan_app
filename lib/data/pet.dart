class Pet {
  String? id;
  String? name;
  String? gender;
  String? type;
  String? breedCode;
  String? breedName;
  String? image;
  bool? isSterilized;
  String? birthday;
  double? recentWeight;
  String? recentPosture;
  double? targetWeight;
  List<String>? recentHealth;
  List<String>? subscriptionNo;

  Pet(
      {this.id,
      this.name,
      this.gender,
      this.type,
      this.breedCode,
      this.breedName,
      this.image,
      this.isSterilized,
      this.birthday,
      this.recentWeight,
      this.recentPosture,
      this.targetWeight,
      this.recentHealth,
      this.subscriptionNo});

  Pet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    gender = json['gender'];
    type = json['type'];
    breedCode = json['breedCode'];
    breedName = json['breedName'];
    image = json['image'];
    isSterilized = json['isSterilized'];
    birthday = json['birthday'];
    recentWeight = json['recentWeight'];
    recentPosture = json['recentPosture'];
    targetWeight = json['targetWeight'];
    recentHealth = json['recentHealth'].cast<String>();
    subscriptionNo=json['subscriptionNo'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['type'] = this.type;
    data['breedCode'] = this.breedCode;
    data['breedName'] = this.breedName;
    data['image'] = this.image;
    data['isSterilized'] = this.isSterilized;
    data['birthday'] = this.birthday;
    data['recentWeight'] = this.recentWeight;
    data['recentPosture'] = this.recentPosture;
    data['targetWeight'] = this.targetWeight;
    data['recentHealth'] = this.recentHealth;
    data['subscriptionNo']=this.subscriptionNo;
    return data;
  }
}
