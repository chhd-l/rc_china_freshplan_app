import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rc_china_freshplan_app/common/util/utils.dart';
import 'package:rc_china_freshplan_app/common/values/colors.dart';
import 'package:rc_china_freshplan_app/common/widgets/factor.dart';
import 'package:rc_china_freshplan_app/common/router/app_router.dart';
import 'package:rc_china_freshplan_app/common/widgets/textFields.dart';
import 'package:rc_china_freshplan_app/pages/checkout/checkout-widget-view.dart';
import 'package:rc_china_freshplan_app/pages/createPet/common-widget-view.dart';

import 'logic.dart';
import 'state.dart';

class CheckoutPage extends StatelessWidget {
  CheckoutPage({super.key});

  final CheckoutLogic logic = Get.put(CheckoutLogic());
  final CheckoutState state = Get.find<CheckoutLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: commonAppBar('确认订单', bgColor: AppColors.bgLinearGradient1),
        body: SafeArea(
          child: Column(children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.bgLinearGradient1,
                            AppColors.bgLinearGradient2
                          ]),
                    ),
                    child: Column(children: [
                      const SizedBox(height: 12),
                      Obx(() => addressContainer(() {
                            logic.global.isCheckoutSelectAddress.value = true;
                            Get.toNamed(AppRoutes.addressManage);
                          }, logic.global.checkoutAddress.value)),
                      Obx(() => orderProductContainer(
                          state.orderProduct, state.productTotalPrice.value)),
                      commonContainer(Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() =>
                              priceRow('商品金额', state.productTotalPrice.value)),
                          priceRow('促销折扣', state.discountPrice, discount: true),
                          priceRow('新人折扣', state.newDiscountPrice,
                              discount: true),
                          priceRow('运费', state.deliveryPrice, discount: true),
                          Row(
                            children: [
                              const Spacer(),
                              Text('合计：', style: textSyle700(fontSize: 14)),
                              Obx(() => Text(
                                    handlePrice(state.payTotalPrice.value),
                                    style: const TextStyle(
                                        fontSize: 20,
                                        color: Color.fromRGBO(212, 157, 40, 1)),
                                  )),
                            ],
                          )
                        ],
                      )),
                      commonContainer(Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            priceRow('首次发货', 0,
                                rightText: DateFormat("yyyy-MM-dd")
                                    .format(DateTime.now()
                                        .add(const Duration(days: 1)))
                                    .toString(),
                                isPrice: false),
                            priceRow('发货周期', 0,
                                rightText: '四周', isPrice: false),
                          ])),
                      commonContainer(
                          padding: const EdgeInsets.only(right: 16, left: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('备注',
                                  style: textSyle700(
                                      fontSize: 14, color: AppColors.text666)),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: textFiled(
                                      controller: logic.remarkController,
                                      focusNode: logic.remarkFocusNode,
                                      fillColor: Colors.white,
                                      hintStyle: const TextStyle(
                                          fontSize: 16,
                                          color:
                                              Color.fromRGBO(204, 204, 204, 1)),
                                      hintText: '留言建议提前协商 (250字内)',
                                      borderWidth: 0,
                                      borderRadius: 0,
                                      textAlign: TextAlign.end),
                                ),
                              ),
                            ],
                          )),
                    ])),
              ),
            ),
            fixBottomContainer(
              Row(
                children: [
                  Text('应付：',
                      style:
                          textSyle700(fontSize: 16, color: AppColors.text333)),
                  Obx(() => Text(
                        handlePrice(state.payTotalPrice.value),
                        style: const TextStyle(
                            fontSize: 16,
                            color: Color.fromRGBO(212, 157, 40, 1)),
                      )),
                  const Spacer(),
                  titleButton('支付', () {
                    logic.pay();
                  }, width: 114, isCircle: true, height: 36)
                ],
              ),
            ),
          ]),
        ));
  }
}
