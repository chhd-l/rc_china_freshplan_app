import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/global.dart';
import 'package:sy_flutter_alipay/sy_flutter_alipay.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:rc_china_freshplan_app/common/util/http.dart';
import 'package:rc_china_freshplan_app/common/values/api_path.dart';

import 'state.dart';

class CheckoutLogic extends GetxController {
  final state = CheckoutState();

  final global = Get.put(GlobalConfigService());

  TextEditingController remarkController = TextEditingController();

  final address = Get.arguments == null
      ? {'name': '左琴', 'phone': '13101227768', 'detail': '重庆渝中区华盛路1号德勤大楼'}
      : Get.arguments['selectAddress'];

  @override
  void onReady() {
    for (var element in global.recipesList) {
      setOrderProduct(element);
    }
    print(global.selectProduct);
    print(state.orderProduct);
    print(state.productTotalPrice);
    super.onReady();
  }

  setOrderProduct(element) {
    if (global.selectProduct.contains(element['value'])) {
      state.orderProduct.insert(0, element);
      state.productTotalPrice.value = state.productTotalPrice.value +
          int.parse(element['price'].toString());
      state.payTotalPrice.value = (state.productTotalPrice.value -
          state.discountPrice -
          state.newDiscountPrice -
          state.deliveryPrice);
    }
  }

  handlePrice(value, {isDiscount = false}) {
    return isDiscount ? '-￥$value.00' : '￥$value.00';
  }

  //获取支付宝支付需要的参数
  getPayInfo() async {
    EasyLoading.show(status: 'loading orderInfo...');
    HttpUtil().get(getOrderInfo, params: {
      // 'pageNum': state.curPageNum.value,
      // 'pageSize': state.pageSize
    }).onError((ErrorEntity error, stackTrace) {
      EasyLoading.showError(error.message!);
    }).then((value) {
      print(value);
      EasyLoading.dismiss();
      if (value == null) return;
      return value;
    });
  }

  void pay() async {
    var payInfo = '"payWayOrderId": "2022090922001402631456201920"';
    // var payInfo = await getPayInfo();
    var result = await SyFlutterAlipay.pay(payInfo,
        urlScheme: 'paydemo', //前面配置的urlScheme
        isSandbox: false //是否是沙箱环境，只对android有效
        );
    print('11111');
    print(result);
  }
}
