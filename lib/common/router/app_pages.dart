import 'package:get/get.dart';
import 'app_router.dart';

import 'package:rc_china_freshplan_app/pages/index/view.dart';
import 'package:rc_china_freshplan_app/pages/pet/createPet/view.dart';
import 'package:rc_china_freshplan_app/pages/pet/createPet/create-pet_next_view.dart';
import 'package:rc_china_freshplan_app/pages/recommendRecipes/view.dart';
import 'package:rc_china_freshplan_app/pages/checkout/view.dart';

class AppPages {
  static const initial = AppRoutes.index;

  static final routes = [
    GetPage(
      name: AppRoutes.index,
      page: () => const IndexPage(),
    ),
    GetPage(
      name: AppRoutes.createPet,
      page: () => const CreatePetPage(),
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
  ];
}
