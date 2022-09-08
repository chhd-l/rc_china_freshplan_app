import 'package:get/get.dart';

class CreatePetLogic extends GetxController {
  final List healthList = [
    {'name': '对食物很挑剔', "select": false},
    {'name': '食物过敏或胃敏感', "select": true},
    {'name': '无光泽或片状被毛', "select": false},
    {'name': '关节炎或关节痛', "select": false},
    {'name': '以上都没有', "select": false},
  ];
}
