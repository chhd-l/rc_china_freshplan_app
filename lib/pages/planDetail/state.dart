import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/data/address.dart';

class PlanDetailState {
  RxList orderProduct = [].obs;
  RxInt productTotalPrice = 0.obs; //商品总价
  RxInt payTotalPrice = 0.obs;
  Rx<AddRess> address = Rx<AddRess>(AddRess());

  int discountPrice = 0; //促销折扣
  int newDiscountPrice = 0; //新人折扣
  int deliveryPrice = 0; //运费

  RxBool isCanceled = false.obs;
}
