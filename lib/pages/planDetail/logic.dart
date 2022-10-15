import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/global.dart';

import 'state.dart';

class PlanDetailLogic extends GetxController {
  final state = PlanDetailState();

  final global = Get.put(GlobalConfigService());

  @override
  void onReady() {
    super.onReady();
  }
}
