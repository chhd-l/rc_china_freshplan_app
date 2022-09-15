import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'common/util/storage.dart';
import 'common/util/pet-util.dart';
import 'common/util/address-util.dart';
import 'api/consumer/index.dart';
import 'constants.dart';
import 'data/pet.dart';

/// 全局配置
class GlobalConfigService extends GetxService {
  RxString petName = ''.obs;
  RxList selectProduct = [].obs;
  RxList recipesList=[].obs;
  Rx<Pet> checkoutPet=Rx<Pet>(Pet());


  final List userList = [
    {'name': '好球', 'mobile': '15095806060'},
    {'name': '好球猫', 'mobile': '19942321506'},
    {'name': '我也笑了', 'mobile': '18983359062'},
    {'name': 'Timyee', 'mobile': '13590415629'},
    {'name': '佐的左', 'mobile': '13101227768'}
  ];

  final List catBreedList = Constants.catPetList;
  final List dogBreedList = Constants.dogBreedList;

  /// 初始化
  Future<GlobalConfigService> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    // 工具初始
    await StorageUtil.init();
    PetUtil.init();
    AddRessUtil.init();
    await ConsumerEndPoint.changeToken();

    return this;
  }
}
