import 'dart:convert';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/common/router/app_router.dart';
import 'package:rc_china_freshplan_app/common/util/http.dart';
import 'package:rc_china_freshplan_app/common/values/api_path.dart';
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
      print(value["data"]["productFindPageByEs"]["records"]);
      global.recipesList
          .insertAll(0, value["data"]["productFindPageByEs"]["records"]);
    });
  }

  //获取推荐产品
  getSubscriptionSimpleRecommend() async {
    EasyLoading.show(status: 'loading subscriptionRecommend...');
    HttpUtil().post(getSubscriptionRecommend, params: {
      "query": getSubscriptionRecommendQuery,
      "variables": {
        "input": {
          "subscriptionType": "FRESH_PLAN",
          "petType": "DOG",
          "petBreedCode": "55",
          "isPetSterilized": false,
          "petBirthday": "2022-03-30T16:00:00.000Z",
          "recentHealth": "NONE"
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
      print('getSubscriptionSimpleRecommend');
      print("productList");
      handleDefaultRecommendProduct(productList);
    });
  }

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

  void selectRecipesItem(value){
    if (selectedProduct.contains(value)) {
      selectedProduct.remove(value);
    } else if (selectedProduct.length < 2) {
      selectedProduct.insert(0, value);
    }
  }

  void gotoPurchase(){
    global.selectProduct.value = selectedProduct;
    Get.toNamed(AppRoutes.checkout);
  }
}
