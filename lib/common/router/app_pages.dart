import 'package:get/get.dart';
import 'app_router.dart';

import 'package:rc_china_freshplan_app/pages/index/view.dart';
import 'package:rc_china_freshplan_app/pages/addressManage/view.dart';
import 'package:rc_china_freshplan_app/pages/newAddress/view.dart';
import 'package:rc_china_freshplan_app/pages/account/view.dart';
import 'package:rc_china_freshplan_app/pages/login/view.dart';
import 'package:rc_china_freshplan_app/pages/pet_list/view.dart';
import 'package:rc_china_freshplan_app/pages/pet_detail/view.dart';
import 'package:rc_china_freshplan_app/pages/createPet/view.dart';
import 'package:rc_china_freshplan_app/pages/createPet/create-pet_next_view.dart';
import 'package:rc_china_freshplan_app/pages/recommendRecipes/view.dart';
import 'package:rc_china_freshplan_app/pages/checkout/view.dart';
import 'package:rc_china_freshplan_app/common/util/storage.dart';

class AppPages {
  static String initial = StorageUtil().getJSON('loginUser') == null
      ? AppRoutes.login
      : AppRoutes.index;

  static final routes = [
    GetPage(
      name: AppRoutes.index,
      page: () => const IndexPage(),
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
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: AppRoutes.petList,
      page: () => const PetListPage(),
    ),
    GetPage(
      name: AppRoutes.petDetail,
      page: () => const PetDetailPage(),
    ),
    GetPage(
      name: AppRoutes.addressManage,
      page: () => const AddRessManage(),
    ),
    GetPage(
      name: AppRoutes.newAddress,
      page: () => const NewAddress(
        name: '',
        details: '',
        open: false,
        phone: '',
        cite: '',
      ),
    ),
  ];
}
