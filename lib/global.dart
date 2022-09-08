import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'common/util/storage.dart';

/// 全局配置
class GlobalConfigService extends GetxService {
  RxString petName=''.obs;
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
