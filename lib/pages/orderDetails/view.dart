import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/common/widgets/factor.dart';
import 'package:rc_china_freshplan_app/pages/orderDetails/logic.dart';

import 'common_view.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final OrderDetailsLogic logic = Get.put(OrderDetailsLogic());
    logic.getOrderDetail(Get.arguments);

    returnPayWayCode() {
      if (logic.payWayCode.value == 'WECHAT_PAY') {
        return '微信';
      } else if (logic.payWayCode.value == 'ALI_PAY') {
        return '支付宝';
      } else {
        return '';
      }
    }

    return Scaffold(
      appBar: commonAppBar('订单详情'),
      body: SingleChildScrollView(
          child: Obx(() => Column(
                children: [
                  Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: Color(0xFFf9f9f9),
                      ),
                      child: Column(
                        children: [
                          //订单状态
                          buildOrderStateView(logic.orderState.value),
                          //物流信息
                          buildDeliveryInfoView(
                              logic.receiverName.value,
                              logic.phone.value,
                              logic.province.value,
                              logic.city.value,
                              logic.region.value,
                              logic.detail.value,
                              logic.delivery),
                          //订单信息
                          buildOrderInfoView(
                              logic.lineItem,
                              logic.productPrice.value,
                              logic.discountsPrice.value,
                              logic.totalPrice.value),
                          //订单支付方式
                          buildOrderPayInfoView(
                              logic.orderNumber.value,
                              logic.subscriptionNo.value,
                              returnPayWayCode(),
                              logic.createdAt.value,
                              logic.createdAt.value,
                              logic.remark.value)
                        ],
                      )),
                ],
              ))),
      bottomNavigationBar: Obx(() => buildOrderOperatorView(
          logic.orderState.value,
          logic.totalPrice.value,
          context,
          logic.delivery,
          logic.orderNumber.value,
          logic.orderDetails)),
    );
  }
}
