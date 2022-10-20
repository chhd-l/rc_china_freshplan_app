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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['gender'] = gender;
    data['type'] = type;
    data['breedCode'] = breedCode;
    data['breedName'] = breedName;
    data['image'] = image;
    data['isSterilized'] = isSterilized;
    data['birthday'] = birthday;
    data['recentWeight'] = recentWeight;
    data['recentPosture'] = recentPosture;
    data['targetWeight'] = targetWeight;
    data['recentHealth'] = recentHealth;
    data['subscriptionNo']=subscriptionNo;
    return data;
  }
}
