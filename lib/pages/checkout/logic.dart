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

  final address = Get.arguments;

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
    // var payInfo = '"payWayOrderId": "2022090922001402631456201920","sign":"ekaow04ZZpRvaR2wpwN1rlGSEVCCdqSmaQiiXfQ5kZMqN1fi/rEE9kLB4/bVDWADKaA3xqwgLCN6hZyYj1LsSBmU3E+eB3gFsI1Q2WQqHvasSbi7Ka2GiJ70lkwqINav+r7AtETr9EO8rSwWNNcWaR2kw4LyTx/1bjzgDVphTL6ZqaSghtNbA7BsyxGa4d1w+p6ZN8MKB2q07vDuvUTwcI7tCihlmAg3GmbVtMYxDxdVF0Y9UhfMbbeQ10byh86xkmFz5P8O7568s4qgx9Ojzr5uU4w8pQJiQVVDNnO3vajqwyULmnEnzMSLC6ZeFhgHMaeSJFlCnjwCQ7YrMxR1NA==';
    // var payInfo = await getPayInfo();
    // var payInfo='alipay_sdk=alipay-sdk-java-3.0.52.ALL&app_id=2017091208686178&biz_content=%7B%22out_trade_no%22%3A%22T_62536%22%2C%22total_amount%22%3A%220.01%22%2C%22subject%22%3A%22%E4%BA%A4%E9%80%9A%E5%AD%A6%E9%99%A2%E7%BD%91%E7%82%B9%E6%B4%97%E8%BD%A6%E6%9C%8D%E5%8A%A1%22%2C%22timeout_express%22%3A%2230m%22%7D&charset=UTF-8&format=json&method=alipay.trade.app.pay&notify_url=https%3A%2F%2Ftpwashlocal.taipuauto.cn%2Fpay%2Fnotify%2Fwash%2Forder%2Fali&sign=RBlcOkoJ3FRQVHATnRDvWi8c4iU1d8kKLIq4lfgA2AbuDcDTH%2FUTeROXNVQQG7EPYfVOK48i1vaIUJB5BmycaRKDSIEOh4qkUS1SbBb3RpBfpKjqs1DFs7uIwccBO%2Bi9Qu%2BDQLvhdyfa%2FrLaEtSlMNzbRRUrEIPSSw5b7ZMDVFVuZleZ5JpQLq3VqGwOUvZ9jVb903B8b867c1LfkgWL3JlgweT3gmATGEg2junnAb3Xitznb4IHQUb8QzQT9oFx0paS1ojKRhkDMCMyCJyOWLxotxbFTu66xGIzdGlD4FEnaMesp9H4AKkB2XgqkT2QQOvSRZdAoigY20cuTBBUQA%3D%3D&sign_type=RSA2&timestamp=2020-03-24+14%3A41%3A26&version=1.0';
    var payInfo =
        'alipay_sdk=alipay-sdk-java-3.0.52.ALL&app_id=2021003146613222&biz_content=%7B%22out_trade_no%22%3A%22O20220909152002568%22%2C%22total_amount%22%3A%220.01%22%2C%22subject%22%3A%22Fresh%20Plan%22%2C%22timeout_express%22%3A%2230m%22%7D&charset=UTF-8&format=json&method=alipay.trade.app.pay&sign=ekaow04ZZpRvaR2wpwN1rlGSEVCCdqSmaQiiXfQ5kZMqN1fi/rEE9kLB4/bVDWADKaA3xqwgLCN6hZyYj1LsSBmU3EeB3gFsI1Q2WQqHvasSbi7Ka2GiJ70lkwqINavr7AtETr9EO8rSwWNNcWaR2kw4LyTx/1bjzgDVphTL6ZqaSghtNbA7BsyxGa4d1wp6ZN8MKB2q07vDuvUTwcI7tCihlmAg3GmbVtMYxDxdVF0Y9UhfMbbeQ10byh86xkmFz5P8O7568s4qgx9Ojzr5uU4w8pQJiQVVDNnO3vajqwyULmnEnzMSLC6ZeFhgHMaeSJFlCnjwCQ7YrMxR1NA==&sign_type=RSA2&timestamp=2022-09-09+15%3A20%3A02&version=1.0';
    var result = await SyFlutterAlipay.pay(payInfo,
        urlScheme: 'paydemo', //前面配置的urlScheme
        isSandbox: true //是否是沙箱环境，只对android有效
        );
    print('11111');
    print(result);
  }
}
