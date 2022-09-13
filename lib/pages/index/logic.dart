import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/common/router/app_router.dart';
import 'package:rc_china_freshplan_app/common/util/event_bus.dart';
import 'package:rc_china_freshplan_app/common/util/storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class IndexLogic extends GetxController {
  RxBool isLogin = false.obs;

  EventBus bus = EventBus();

  @override
  void onReady() {
    print(StorageUtil().getJSON("loginUser"));
    isLogin.value = StorageUtil().getJSON("loginUser") != null;
    bus.addListener('user-login', (arg) {
      isLogin.value = true;
    });
    super.onReady();
  }

  void customizedFreshFood() {
    if (isLogin.value) {
      Get.toNamed(AppRoutes.createPet);
    } else {
      EasyLoading.showToast('您还没有登录哦~~~');
    }
  }
}
