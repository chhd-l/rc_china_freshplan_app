import 'package:get/get.dart';
import 'app_router.dart';

import 'package:rc_china_freshplan_app/pages/index/view.dart';
import 'package:rc_china_freshplan_app/pages/addressManage/view.dart';
import 'package:rc_china_freshplan_app/pages/newAddress/view.dart';
import 'package:rc_china_freshplan_app/pages/account/view.dart';
import 'package:rc_china_freshplan_app/pages/account/controller.dart';
import 'package:rc_china_freshplan_app/pages/login/view.dart';
import 'package:rc_china_freshplan_app/pages/pet_list/view.dart';
import 'package:rc_china_freshplan_app/pages/pet_list/controller.dart';
import 'package:rc_china_freshplan_app/pages/pet_detail/view.dart';
import 'package:rc_china_freshplan_app/pages/createPet/view.dart';
import 'package:rc_china_freshplan_app/pages/createPet/create-pet_next_view.dart';
import 'package:rc_china_freshplan_app/pages/recommendRecipes/view.dart';
import 'package:rc_china_freshplan_app/pages/checkout/view.dart';
import 'package:rc_china_freshplan_app/pages/orderList/view.dart';
import 'package:rc_china_freshplan_app/pages/OrderDetails/view.dart';
import 'package:rc_china_freshplan_app/common/util/storage.dart';

class AppPages {
  static String initial = StorageUtil().getJSON('loginUser') == null
      ? AppRoutes.login
      : AppRoutes.index;

  static final routes = [
    GetPage(
      name: AppRoutes.index,
      page: () => IndexPage(),
    ),
    GetPage(
      name: AppRoutes.createPet,
      page: () => CreatePetPage(),
    ),
    GetPage(
      name: AppRoutes.createPetNext,
      page: () => CreatePetNextPage(),
    ),
    GetPage(
      name: AppRoutes.recommendRecipes,
      page: () => RecommendRecipesPage(),
    ),
    GetPage(
      name: AppRoutes.checkout,
      page: () => CheckoutPage(),
    ),
    GetPage(
      name: AppRoutes.account,
      page: () => const AccountPage(),
      binding: BindingsBuilder(
          () => Get.lazyPut<AccountController>(() => AccountController())),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: AppRoutes.petList,
      page: () => const PetListPage(),
      binding: BindingsBuilder(
          () => Get.lazyPut<PetListController>(() => PetListController())),
    ),
    GetPage(
      name: AppRoutes.petDetail,
      page: () => PetDetailPage(),
    ),
    GetPage(
      name: AppRoutes.addressManage,
      page: () => AddressManage(),
    ),
    GetPage(
      name: AppRoutes.newAddress,
      page: () => const NewAddress(),
    ),
    GetPage(
      name: AppRoutes.orderList,
      page: () => const OrderList(),
    ),
    GetPage(
      name: AppRoutes.orderDetails,
      page: () => const OrderDetails(),
    ),
  ];
}
