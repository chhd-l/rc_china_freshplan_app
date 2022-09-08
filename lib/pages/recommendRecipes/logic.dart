import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/global.dart';

class RecommendRecipesLogic extends GetxController {
  RxList selectedProduct = [0].obs;

  String petName=Get.put(GlobalConfigService()).petName.value;

  final List recipesList = [
    {
      'name': '牛肉泥',
      'description': '牛肉、土豆、鸡蛋、胡萝卜、豌豆',
      'assets': 'assets/images/牛肉泥.png',
      "value": 0
    },
    {
      'name': '火鸡料理',
      'description': '火鸡、糙米、鸡蛋、胡萝卜、菠菜',
      'assets': 'assets/images/火鸡料理.png',
      "value": 1
    },
    {
      'name': '鸡肉料理',
      'description': '鸡肉、红薯、南瓜、菠菜',
      'assets': 'assets/images/鸡肉料理.png',
      "value": 2
    },
    {
      'name': '猪肉便饭',
      'description': '猪肉、土豆、青豆、南瓜、羽衣甘蓝、蘑菇',
      'assets': 'assets/images/猪肉便饭.png',
      "value": 3
    },
  ];
}
