import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/common/router/app_router.dart';
import 'package:rc_china_freshplan_app/common/util/http.dart';
import 'package:rc_china_freshplan_app/common/util/utils.dart';
import 'package:rc_china_freshplan_app/common/values/api_path.dart';
import 'package:rc_china_freshplan_app/data/pet.dart';
import 'package:rc_china_freshplan_app/global.dart';

import 'get_products_params.dart';
import 'subscription_recommend_query.dart';

class RecommendRecipesLogic extends GetxController {
  RxList recommendProduct = [].obs;
  RxList selectedProduct = [].obs;
  RxString recommendProductsName = ''.obs;

  final global = Get.put(GlobalConfigService());

  @override
  void onReady() async {
    if (global.recipesList.isEmpty) {
      await getProductList();
    }
    await getSubscriptionSimpleRecommend();
    super.onReady();
  }

  //获取产品列表
  getProductList() {
    EasyLoading.show(status: 'loading productList...');
    HttpUtil()
        .post(getProducts, params: getProductsParams)
        .onError((ErrorEntity error, stackTrace) {
      EasyLoading.showError(error.message!);
    }).then((value) {
      EasyLoading.dismiss();
      if (value == null) return;
      value = json.decode(value.toString());
      global.recipesList
          .insertAll(0, value["data"]["productFindPageByEs"]["records"]);
    });
  }

  //获取推荐产品
  getSubscriptionSimpleRecommend() async {
    Pet pet = global.checkoutPet.value;
    EasyLoading.show(status: 'loading subscriptionRecommend...');
    HttpUtil().post(getSubscriptionRecommend, params: {
      "query": getSubscriptionRecommendQuery,
      "variables": {
        "input": {
          "subscriptionType": "FRESH_PLAN",
          "petType": pet.type,
          "petBreedCode": pet.breedCode,
          "isPetSterilized": false,
          "petBirthday":
              handleDateTimeToZone(DateTime.parse(pet.birthday.toString())),
          "recentHealth": (pet.recentHealth ?? []).join('|')
        }
      }
    }).onError((ErrorEntity error, stackTrace) {
      EasyLoading.showError(error.message!);
    }).then((value) {
      EasyLoading.dismiss();
      if (value == null) return;
      value = json.decode(value.toString());
      var productList =
          value["data"]["subscriptionSimpleRecommend"]["productList"];
      handleDefaultRecommendProduct(productList);
    });
  }

  //处理默认推荐的套餐
  void handleDefaultRecommendProduct(productList) {
    for (var element in productList) {
      for (var item in global.recipesList) {
        if (item["variants"][0]["id"] ==
            element["productVariantInfo"]["variants"][0]["id"]) {
          recommendProduct.insert(0, item["variants"][0]["id"]);
          selectedProduct.insert(0, item["variants"][0]["id"]);
          recommendProductsName.value = recommendProductsName + item["name"];
        }
      }
    }
  }

  //点击套餐
  void selectRecipesItem(value) {
    if (selectedProduct.contains(value)) {
      selectedProduct.remove(value);
    } else if (selectedProduct.length < 2) {
      selectedProduct.insert(0, value);
    }
  }

  //立即购买
  void gotoPurchase() {
    global.selectProduct.value = selectedProduct;
    Get.toNamed(AppRoutes.checkout);
  }
}
