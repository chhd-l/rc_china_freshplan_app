import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/pages/recipes_view.dart';
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
import 'package:rc_china_freshplan_app/pages/recommendRecipes/view.dart';
import 'package:rc_china_freshplan_app/pages/checkout/view.dart';
import 'package:rc_china_freshplan_app/pages/orderList/view.dart';
import 'package:rc_china_freshplan_app/pages/OrderDetails/view.dart';
import 'package:rc_china_freshplan_app/pages/register/view.dart';
import 'package:rc_china_freshplan_app/pages/reset_password/verification.dart';
import 'package:rc_china_freshplan_app/pages/reset_password/reset.dart';
import 'package:rc_china_freshplan_app/common/util/storage.dart';
import 'package:rc_china_freshplan_app/pages/subscriptionDetail/view.dart';
import 'package:rc_china_freshplan_app/pages/createPet/choosePet/view.dart';
import 'package:rc_china_freshplan_app/pages/breedPicker/view.dart';
import 'package:rc_china_freshplan_app/pages/planDetail/view.dart';
import 'package:rc_china_freshplan_app/pages/invoiceManage/view.dart';
import 'package:rc_china_freshplan_app/pages/invoiceDetail/view.dart';

class AppPages {
  static String initial = StorageUtil().getJSON('loginUser') == null
      ? AppRoutes.login
      : AppRoutes.account;

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
      name: AppRoutes.register,
      page: () => const RegisterPage(),
    ),
    GetPage(
      name: AppRoutes.resetPasswordStep1,
      page: () => const ResetPasswordVerifyPage(),
    ),
    GetPage(
      name: AppRoutes.resetPasswordStep2,
      page: () => const ResetPasswordResetPage(),
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
      page: () => const AddressManage(),
    ),
    GetPage(
      name: AppRoutes.newAddress,
      page: () => NewAddress(),
    ),
    GetPage(
      name: AppRoutes.orderList,
      page: () => OrderList(),
    ),
    GetPage(
      name: AppRoutes.orderDetails,
      page: () => const OrderDetails(),
    ),
    GetPage(
      name: AppRoutes.subscriptionDetail,
      page: () => SubscriptionDetailPage(),
    ),
    GetPage(
      name: AppRoutes.recipesPage,
      page: () => const RecipesPage(),
    ),
    GetPage(
      name: AppRoutes.choosePet,
      page: () => ChoosePetPage(),
    ),
    GetPage(
      name: AppRoutes.breedPick,
      page: () => BreedListPickerPage(),
    ),
    GetPage(
      name: AppRoutes.planDetail,
      page: () => PlanDetailPage(),
    ),
    GetPage(
      name: AppRoutes.invoiceManage,
      page: () => InvoiceManagePage(),
    ),
    GetPage(
      name: AppRoutes.invoiceDetail,
      page: () => InvoiceDetailPage(),
    ),
  ];
}
