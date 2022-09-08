import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/global.dart';

import 'state.dart';

class CheckoutLogic extends GetxController {
  final state = CheckoutState();

  final global = Get.put(GlobalConfigService());

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
}
