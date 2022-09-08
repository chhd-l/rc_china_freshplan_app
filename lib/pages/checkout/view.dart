import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:rc_china_freshplan_app/common/values/colors.dart';
import 'package:rc_china_freshplan_app/common/widgets/factor.dart';
import 'package:rc_china_freshplan_app/common/router/app_router.dart';
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
                      commonContainer(Row(
                        children: [
                          Image.asset('assets/images/address.png'),
                          const SizedBox(width: 8),
                          Text(
                            '添加收货地址',
                            style: textSyle700(
                                fontSize: 17, color: AppColors.text333),
                          ),
                          const Spacer(),
                          Image.asset('assets/images/arrow-right.png'),
                        ],
                      )),
                      commonContainer(Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('订单商品', style: textSyle700(fontSize: 16)),
                          Obx(
                            () => ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: state.orderProduct.length,
                                itemBuilder: (context, index) {
                                  final item = state.orderProduct[index];
                                  return Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(item['assets']),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: Column(
                                          children: [
                                            Text(item['name'],
                                                style: textSyle700(
                                                    fontSize: 14,
                                                    color: AppColors.text333)),
                                            Text(
                                                logic
                                                    .handlePrice(item['price']),
                                                style: textSyle700(
                                                    fontSize: 12,
                                                    color: AppColors.text999)),
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(top: 20),
                                          child: Text('X1',
                                              style: textSyle700(
                                                  fontSize: 10,
                                                  color: AppColors.text999))),
                                    ],
                                  );
                                }),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Obx(() => RichText(
                                    textAlign: TextAlign.end,
                                    text: TextSpan(
                                        style: textSyle700(
                                            fontSize: 14,
                                            color: AppColors.text666),
                                        children: [
                                          const TextSpan(text: '商品小计：'),
                                          TextSpan(
                                            text: logic.handlePrice(
                                                state.productTotalPrice.value),
                                            style: const TextStyle(
                                                color: AppColors.primaryText),
                                          ),
                                        ]),
                                  )),
                            ],
                          )
                        ],
                      )),
                      commonContainer(Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() => priceRow(
                              '商品金额',
                              logic
                                  .handlePrice(state.productTotalPrice.value))),
                          priceRow(
                              '促销折扣',
                              logic.handlePrice(state.discountPrice,
                                  isDiscount: true)),
                          priceRow(
                              '新人折扣',
                              logic.handlePrice(state.newDiscountPrice,
                                  isDiscount: true)),
                          priceRow(
                              '运费',
                              logic.handlePrice(state.deliveryPrice,
                                  isDiscount: true)),
                          Row(
                            children: [
                              const Spacer(),
                              Text('合计：', style: textSyle700(fontSize: 14)),
                              Obx(() => Text(
                                    logic
                                        .handlePrice(state.payTotalPrice.value),
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
                            priceRow(
                                '首次发货',
                                DateFormat("yyyy-MM-dd")
                                    .format(DateTime.now())
                                    .toString()),
                            priceRow('发货周期', '四周'),
                          ])),
                      commonContainer(Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('备注',
                              style: textSyle700(
                                  fontSize: 14, color: AppColors.text666)),
                          Text('留言建议提前协商 (250字内)',
                              style: textSyle700(
                                  fontSize: 14, color: AppColors.text333)),
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
                        logic.handlePrice(state.payTotalPrice.value),
                        style: const TextStyle(
                            fontSize: 16,
                            color: Color.fromRGBO(212, 157, 40, 1)),
                      )),
                  const Spacer(),
                  titleButton('支付', () {
                    Get.offAllNamed(AppRoutes.recommendRecipes);
                  }, width: 114, isCircle: true, height: 36)
                ],
              ),
            )
          ]),
        ));
  }
}

Widget commonContainer(Widget child) {
  return Container(
    padding: const EdgeInsets.all(16),
    margin: const EdgeInsets.only(bottom: 15),
    decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 0),
              color: Color.fromRGBO(191, 191, 191, 0.1),
              blurRadius: 2.0,
              blurStyle: BlurStyle.solid,
              spreadRadius: 0.0)
        ]),
    child: child,
  );
}

Widget priceRow(String left, String right) {
  return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(left,
              style: textSyle700(fontSize: 14, color: AppColors.text666)),
          Text(right,
              style: textSyle700(fontSize: 14, color: AppColors.text333)),
        ],
      ));
}
