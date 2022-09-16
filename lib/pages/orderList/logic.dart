import 'package:get/get.dart';

import 'package:rc_china_freshplan_app/common/util/order_util.dart';
import 'package:rc_china_freshplan_app/data/order.dart';

class OrderLogic extends GetxController {
  var tagType = 'ALL'.obs;
  var orderLists = [].obs;

  void getOrderList(String type) {
    OrderUtil.getOrders(type).then((value) {
      if(value != null) {
        orderLists.value = value;
      } else {
        orderLists.value = [];
      }
    });
  }

  void onChangeTagType (String text) => {
    tagType.value = text
  };
}