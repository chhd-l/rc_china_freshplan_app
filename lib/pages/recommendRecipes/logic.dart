import 'dart:math';

import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/global.dart';

class RecommendRecipesLogic extends GetxController {
  final int initIndex=Random().nextInt(4);
  RxList selectedProduct = [].obs;

  String petName = Get.put(GlobalConfigService()).petName.value;

  final global = Get.put(GlobalConfigService());

  @override
  void onReady() {
    selectedProduct.insert(0, initIndex);
    super.onReady();
  }
}
