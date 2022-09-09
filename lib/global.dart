import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'common/util/storage.dart';

/// 全局配置
class GlobalConfigService extends GetxService {
  RxString petName=''.obs;
  RxList selectProduct=[].obs;

  final List recipesList = [
    {
      'name': '牛肉泥',
      'description': '牛肉、土豆、鸡蛋、胡萝卜、豌豆',
      'assets': 'assets/images/牛肉泥.png',
      "value": 0,
      "price":129
    },
    {
      'name': '火鸡料理',
      'description': '火鸡、糙米、鸡蛋、胡萝卜、菠菜',
      'assets': 'assets/images/火鸡料理.png',
      "value": 1,
      "price":129
    },
    {
      'name': '鸡肉料理',
      'description': '鸡肉、红薯、南瓜、菠菜',
      'assets': 'assets/images/鸡肉料理.png',
      "value": 2,
      "price":129
    },
    {
      'name': '猪肉便饭',
      'description': '猪肉、土豆、青豆、南瓜、羽衣甘蓝、蘑菇',
      'assets': 'assets/images/猪肉便饭.png',
      "value": 3,
      "price":129
    },
  ];

  // ///getter setter
  // String get petName {
  //   return StorageUtil().getStr('petName');
  // }
  //
  // set petName(String value) {
  //   StorageUtil().setStr('petName', value);
  // }

  /// 初始化
  Future<GlobalConfigService> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    // 工具初始
    await StorageUtil.init();

    return this;
  }
}
