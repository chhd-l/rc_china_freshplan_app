import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/common/router/app_router.dart';
import 'package:rc_china_freshplan_app/common/util/address_util.dart';
import 'package:rc_china_freshplan_app/common/util/pet_util.dart';
import 'package:rc_china_freshplan_app/common/util/storage.dart';

class SettingLogic extends GetxController {
  //退出登录
  void signOut() {
    StorageUtil().clear();
    PetUtil.logout();
    AddRessUtil.logout();
    Get.offAllNamed(AppRoutes.login);
  }

  //注销账号
  void logout() {
    StorageUtil().clear();
    PetUtil.logout();
    AddRessUtil.logout();
    Get.offAllNamed(AppRoutes.login);
  }
}
