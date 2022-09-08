import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:rc_china_freshplan_app/common/values/colors.dart';
import 'package:rc_china_freshplan_app/common/widgets/factor.dart';
import 'package:rc_china_freshplan_app/common/router/app_router.dart';

import 'logic.dart';
import 'state.dart';

class CheckoutPage extends StatelessWidget {
  CheckoutPage({super.key});

  final CheckoutLogic logic = Get.put(CheckoutLogic());
  final CheckoutState state = Get.find<CheckoutLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(191, 191, 191, 0.1),
        appBar: commonAppBar('确认订单',
            bgColor: const Color.fromARGB(255, 195, 236, 123)),
        body: SafeArea(
          child: Column(children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.only(
                        right: 12.w, left: 12.w, top: 24.w, bottom: 16.h),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromARGB(255, 195, 236, 123),
                            Color.fromARGB(0, 195, 236, 123),
                          ]),
                    ),
                    child: Column(children: [
                      commonContainer(Row(
                        children: [
                          Image.asset('assets/images/address.png'),
                          const SizedBox(width: 8),
                          Text(
                            '添加收货地址',
                            style: textSyle700(
                                fontSize: 17,
                                color: const Color.fromRGBO(51, 51, 51, 1)),
                          ),
                          const Spacer(),
                          Image.asset('assets/images/arrow-right.png'),
                        ],
                      )),
                      commonContainer(Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '订单商品',
                            style: textSyle700(
                                fontSize: 16,
                                color: const Color.fromRGBO(0, 0, 0, 1)),
                          ),
                          Obx(
                            () => ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: state.orderProduct.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                          state.orderProduct[index]['assets']),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: Column(
                                          children: [
                                            Text(
                                                state.orderProduct[index]
                                                    ['name'],
                                                style: textSyle700(
                                                    fontSize: 14,
                                                    color: const Color.fromRGBO(
                                                        51, 51, 51, 1))),
                                            Text(
                                                logic.handlePrice(
                                                    state.orderProduct[index]
                                                        ['price']),
                                                style: textSyle700(
                                                    fontSize: 12,
                                                    color: const Color.fromRGBO(
                                                        153, 153, 153, 1))),
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
                                                  color: const Color.fromRGBO(
                                                      157, 157, 157, 1)))),
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
                                            color: const Color.fromRGBO(
                                                102, 102, 102, 1)),
                                        children: [
                                          const TextSpan(text: '商品小计：'),
                                          TextSpan(
                                            text: logic.handlePrice(
                                                state.productTotalPrice.value),
                                            style: const TextStyle(
                                                color:
                                                    Color.fromRGBO(0, 0, 0, 1)),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('商品金额',
                                  style: textSyle700(
                                      fontSize: 14,
                                      color: const Color.fromRGBO(
                                          102, 102, 102, 1))),
                              Obx(() => Text(
                                  logic.handlePrice(
                                      state.productTotalPrice.value),
                                  style: textSyle700(
                                      fontSize: 14,
                                      color: const Color.fromRGBO(
                                          51, 51, 51, 1)))),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('促销折扣',
                                  style: textSyle700(
                                      fontSize: 14,
                                      color: const Color.fromRGBO(
                                          102, 102, 102, 1))),
                              Text('-¥20.00',
                                  style: textSyle700(
                                      fontSize: 14,
                                      color:
                                          const Color.fromRGBO(51, 51, 51, 1))),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('新人折扣',
                                  style: textSyle700(
                                      fontSize: 14,
                                      color: const Color.fromRGBO(
                                          102, 102, 102, 1))),
                              Text('-¥20.00',
                                  style: textSyle700(
                                      fontSize: 14,
                                      color:
                                          const Color.fromRGBO(51, 51, 51, 1))),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('运费',
                                  style: textSyle700(
                                      fontSize: 14,
                                      color: const Color.fromRGBO(
                                          102, 102, 102, 1))),
                              Text('¥0.00',
                                  style: textSyle700(
                                      fontSize: 14,
                                      color:
                                          const Color.fromRGBO(51, 51, 51, 1))),
                            ],
                          ),
                          Row(
                            children: [
                              const Spacer(),
                              Text('合计：',
                                  style: textSyle700(
                                      fontSize: 14,
                                      color: const Color.fromRGBO(0, 0, 0, 1))),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('首次发货',
                                    style: textSyle700(
                                        fontSize: 14,
                                        color: const Color.fromRGBO(
                                            102, 102, 102, 1))),
                                Text(
                                    DateFormat("yyyy-MM-dd")
                                        .format(DateTime.now())
                                        .toString(),
                                    style: textSyle700(
                                        fontSize: 14,
                                        color: const Color.fromRGBO(
                                            51, 51, 51, 1))),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('发货周期',
                                    style: textSyle700(
                                        fontSize: 14,
                                        color: const Color.fromRGBO(
                                            102, 102, 102, 1))),
                                Text('四周',
                                    style: textSyle700(
                                        fontSize: 14,
                                        color: const Color.fromRGBO(
                                            51, 51, 51, 1))),
                              ],
                            ),
                          ])),
                      commonContainer(Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('备注',
                              style: textSyle700(
                                  fontSize: 14,
                                  color:
                                      const Color.fromRGBO(102, 102, 102, 1))),
                          Text('留言建议提前协商 (250字内)',
                              style: textSyle700(
                                  fontSize: 14,
                                  color: const Color.fromRGBO(51, 51, 51, 1))),
                        ],
                      )),
                    ])),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                        color: AppColors.tabCellSeparator, width: 1.0),
                  ),
                  color: Colors.white),
              padding: EdgeInsets.fromLTRB(24.w, 19.h, 24.w, 19.h),
              child: Row(
                children: [
                  Text('应付：',
                      style: textSyle700(
                          fontSize: 16,
                          color: const Color.fromRGBO(51, 51, 51, 1))),
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
