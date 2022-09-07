import 'package:get/get.dart';
import 'app_router.dart';

import 'package:rc_china_freshplan_app/pages/index/view.dart';
import 'package:rc_china_freshplan_app/pages/addressManage/view.dart';
import 'package:rc_china_freshplan_app/pages/account/view.dart';
import 'package:rc_china_freshplan_app/pages/login/view.dart';
import 'package:rc_china_freshplan_app/pages/pet_list/view.dart';
import 'package:rc_china_freshplan_app/pages/pet_detail/view.dart';

class AppPages {
  static const initial = AppRoutes.index;

  static final routes = [
    GetPage(
      name: AppRoutes.index,
      page: () => const IndexPage(),
    ),
    GetPage(
      name: AppRoutes.account,
      page: () => AccountPage(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => LoginPage(),
    ),
    GetPage(
      name: AppRoutes.petList,
      page: () => PetListPage(),
    ),
    GetPage(
      name: AppRoutes.petDetail,
      page: () => PetDetailPage(),
    ),
  ];
}
