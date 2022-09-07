import 'package:get/get.dart';
import 'app_router.dart';

import 'package:rc_china_freshplan_app/pages/index/view.dart';

class AppPages {
  static const initial = AppRoutes.index;

  static final routes = [
    GetPage(
      name: AppRoutes.index,
      page: () => IndexPage(),
    ),
  ];
}
