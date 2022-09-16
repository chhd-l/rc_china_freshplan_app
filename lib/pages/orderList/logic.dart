import 'package:get/get.dart';

import 'package:rc_china_freshplan_app/common/util/order_util.dart';
import 'package:rc_china_freshplan_app/data/order.dart';

class OrderLogic extends GetxController {
  var tagType = 'ALL'.obs;

  List<Order> orderLists = [];

  void getOrderList() {
    OrderUtil.getOrders(tagType.value).then((value) {
      orderLists.clear();
      orderLists.addAll(value);
      update();
    });
  }

  void onChangeTagType(String text) => {tagType.value = text};
}
