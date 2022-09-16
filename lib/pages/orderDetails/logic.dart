import 'package:get/get.dart';

import 'package:rc_china_freshplan_app/common/util/order_util.dart';
import 'package:rc_china_freshplan_app/data/order.dart';

class OrderDetailsLogic extends GetxController {

  var orderDetails = {};

  // 订单状态
  var orderState = ''.obs;
  // 支付平台
  var payWayCode = ''.obs;
  // 地址
  var receiverName = ''.obs;
  var phone = ''.obs;
  var province = ''.obs;
  var city = ''.obs;
  var region = ''.obs;
  var detail = ''.obs;
  // 商品列表
  var lineItem = [].obs;
  // 订单金额
  var productPrice = ''.obs;
  var deliveryPrice = ''.obs;
  var discountsPrice = ''.obs;
  var vipDiscountsPrice = ''.obs;
  var totalPrice = ''.obs;
  // 订单编号
  var orderNumber = ''.obs;
  var subscriptionNo = ''.obs;
  // 付款时间
  var paymentFinishTime = ''.obs;
  // 创建时间
  var createdAt = ''.obs;
  // 买家留言
  var remark = ''.obs;

  void getOrderList(String orderNum) {
    OrderUtil.getOrderDetail(orderNum).then((value) {
      print('orderDetails');
      print(value['remark']);

      orderDetails = value;

      orderNumber.value = value['orderNumber'];
      subscriptionNo.value = value['subscriptionNo'];
      orderState.value = value['orderState']['orderState'];
      payWayCode.value = value['payment']['payWayCode'];

      receiverName.value = value['shippingAddress']['receiverName'];
      phone.value = value['shippingAddress']['phone'];
      province.value = value['shippingAddress']['province'];
      city.value = value['shippingAddress']['city'];
      region.value = value['shippingAddress']['region'];
      detail.value = value['shippingAddress']['detail'];

      lineItem.value = value['lineItem'];

      productPrice.value = value['orderPrice']['productPrice'];
      deliveryPrice.value = value['orderPrice']['deliveryPrice'];
      discountsPrice.value = value['orderPrice']['discountsPrice'];
      vipDiscountsPrice.value = value['orderPrice']['vipDiscountsPrice'];
      totalPrice.value = value['orderPrice']['totalPrice'];
      // print(int.parse(productPrice.value) + int.parse(deliveryPrice.value));
      // print(int.parse(discountsPrice.value) + int.parse(vipDiscountsPrice.value));
      // print((int.parse(discountsPrice.value) + int.parse(vipDiscountsPrice.value)) > 0);
      // print(totalPrice.value);

      paymentFinishTime.value = value['payment']['paymentFinishTime'];
      createdAt.value = value['orderState']['createdAt'];
      remark.value = value['remark'];
    });
  }
}