import 'package:get/get.dart';

class CheckoutState {
  RxList orderProduct = [].obs;
  RxInt productTotalPrice = 0.obs; //商品总价
  RxInt payTotalPrice=0.obs;

  int discountPrice = 20; //促销折扣
  int newDiscountPrice = 20; //新人折扣
  int deliveryPrice = 0; //运费
}
