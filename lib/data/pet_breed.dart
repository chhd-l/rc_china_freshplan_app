import 'dart:convert';

import 'package:azlistview/azlistview.dart';

class PetBreed extends ISuspensionBean {
  String? name;
  String? code;
  String? tagIndex;
  String? namePinyin;

  PetBreed({
    this.name,
    this.code,
    this.tagIndex,
    this.namePinyin,
  });

  PetBreed.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? '';
    code = json['code'] ?? '';
    namePinyin = json['namePinyin'] ?? '';
    tagIndex = json['tagIndex'] ?? '';
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'code': code,
      };

  @override
  String getSuspensionTag() => tagIndex ?? '';

  @override
  String toString() => json.encode(this);
}
