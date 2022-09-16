import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rc_china_freshplan_app/common/router/app_router.dart';
import 'package:flutter/services.dart';
import 'package:rc_china_freshplan_app/pages/orderDetails/logic.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final OrderDetailsLogic logic = Get.put(OrderDetailsLogic());
    logic.getOrderList(Get.arguments);
    // logic.getOrderList('O20220915200200498');

    returnTitleText(String type) {
      if (type == 'UNPAID') {
        return '等待买家付款';
      } else if (type == 'TO_SHIP') {
        return '等待商家发货';
      } else if (type == 'SHIPPED') {
        return '商家已发货';
      } else if (type == 'COMPLETED') {
        return '交易完成';
      } else {
        return '交易关闭';
      }
    }

    returnTypeText(String type) {
      if (type == 'UNPAID') {
        return '请于订单创建后30分钟内付款,超时订单将自动关闭';
      } else if (type == 'TO_SHIP') {
        return '商家会在七天内发货';
      } else if (type == 'SHIPPED') {
        return '商品正在路上，请耐心等待';
      } else if (type == 'COMPLETED') {
        return '交易已完成';
      } else {
        return '订单已取消';
      }
    }

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
        appBar: AppBar(
          title: const Text('订单详情'),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: GestureDetector(
            child: const Icon(
              Icons.arrow_back_ios,
            ),
            onTap: () {
              Get.toNamed(AppRoutes.orderList);
            },
          ),
        ),
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
                            Container(
                              alignment: Alignment.topLeft,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(returnTitleText(logic.orderState.value),
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15)),
                                  Text(returnTypeText(logic.orderState.value),
                                      style: const TextStyle(
                                          color: Color(0xFF666666),
                                          fontSize: 12)),
                                ],
                              ),
                            ),
                            Container(
                                alignment: Alignment.topLeft,
                                padding: const EdgeInsets.all(12),
                                margin:
                                    const EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(right: 12),
                                      child: Image.asset(
                                          'assets/images/address.png'),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text('${logic.receiverName.value} ',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15)),
                                            Text(' ${logic.phone}',
                                                style: const TextStyle(
                                                    color: Color(0xFF666666),
                                                    fontSize: 12)),
                                          ],
                                        ),
                                        Text(
                                            '${logic.province.value} ${logic.city.value} ${logic.region.value} ${logic.detail.value}'),
                                      ],
                                    )
                                  ],
                                )),
                            Container(
                              alignment: Alignment.topLeft,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 12),
                                    child: const Text('订单详情',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(fontSize: 15)),
                                  ),
                                  ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: logic.lineItem.length,
                                      itemBuilder: (BuildContext ctx, int i) {
                                        var item = logic.lineItem[i];
                                        return Row(
                                          children: [
                                            Image.network(
                                              item['pic'],
                                              width: 90,
                                              height: 90,
                                              fit: BoxFit.cover,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(item['spuName'],
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      Text('X ${item['num']}',
                                                          style: const TextStyle(
                                                              color: Color(
                                                                  0xFF666666),
                                                              fontSize: 12)),
                                                    ],
                                                  ),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 12),
                                                    child: Text(
                                                        '￥${item["price"]}',
                                                        style: const TextStyle(
                                                            color: Color(
                                                                0xFF666666),
                                                            fontSize: 12)),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        );
                                      }),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        bottom: 12, top: 12),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('商品金额',
                                            style: TextStyle(
                                              color: Color(0xFF666666),
                                            )),
                                        Text('¥${logic.productPrice.value}.00',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                  Container(
                                      child: logic.discountsPrice.value != '0'
                                          ? Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 12),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text('促销折扣',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF666666),
                                                      )),
                                                  Text(
                                                      '-¥${logic.discountsPrice.value}.00',
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ],
                                              ))
                                          : null),
                                  Container(
                                      margin: const EdgeInsets.only(bottom: 12),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('商品金额',
                                              style: TextStyle(
                                                color: Color(0xFF666666),
                                              )),
                                          Text(
                                              '¥${logic.discountsPrice.value}.00',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      )),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Text('合计：'),
                                      Text(' ￥${logic.totalPrice.value}.00',
                                          style: const TextStyle(
                                              color: Color(0xFFD49D28),
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              padding: const EdgeInsets.all(12),
                              margin: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                      margin: const EdgeInsets.only(bottom: 12),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Text('配送方式',
                                              style: TextStyle(
                                                color: Color(0xFF666666),
                                              )),
                                          Text('快递'),
                                        ],
                                      )),
                                  Container(
                                      margin: const EdgeInsets.only(bottom: 12),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('订单编号',
                                              style: TextStyle(
                                                  color: Color(0xFF666666))),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(logic.orderNumber.value),
                                              Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 2),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Clipboard.setData(
                                                          ClipboardData(
                                                              text: logic
                                                                  .orderNumber
                                                                  .value));
                                                    },
                                                    child: const Icon(
                                                      Icons.library_books,
                                                      color: Color(0xFF96CC39),
                                                      size: 14,
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ],
                                      )),
                                  Container(
                                      margin: const EdgeInsets.only(bottom: 12),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('计划编号',
                                              style: TextStyle(
                                                  color: Color(0xFF666666))),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(logic.subscriptionNo.value),
                                              Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 2),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Clipboard.setData(
                                                          ClipboardData(
                                                              text: logic
                                                                  .subscriptionNo
                                                                  .value));
                                                    },
                                                    child: const Icon(
                                                      Icons.library_books,
                                                      color: Color(0xFF96CC39),
                                                      size: 14,
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ],
                                      )),
                                  Container(
                                      margin: const EdgeInsets.only(bottom: 12),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('付款方式',
                                              style: TextStyle(
                                                color: Color(0xFF666666),
                                              )),
                                          Text(returnPayWayCode()),
                                        ],
                                      )),
                                  Container(
                                      margin: const EdgeInsets.only(bottom: 12),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('付款时间',
                                              style: TextStyle(
                                                color: Color(0xFF666666),
                                              )),
                                          Text(logic.createdAt.value != ''
                                              ? DateFormat(
                                                      'yyyy-MM-dd HH:mm:ss')
                                                  .format(DateTime.parse(
                                                      logic.createdAt.value))
                                              : logic.createdAt.value),
                                        ],
                                      )),
                                  Container(
                                      margin: const EdgeInsets.only(bottom: 12),
                                      alignment: Alignment.topLeft,
                                      child: const Text('备注',
                                          style: TextStyle(
                                            color: Color(0xFF666666),
                                          ))),
                                  TextField(
                                    enabled: false,
                                    minLines: 3,
                                    maxLines: 5,
                                    decoration: InputDecoration(
                                        hintText: logic.remark.value,
                                        hintStyle: const TextStyle(
                                            color: Colors.black, fontSize: 14),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: BorderSide.none),
                                        filled: true,
                                        fillColor: const Color(0xfff6f6f6)),
                                  )
                                ],
                              ),
                            )
                          ],
                        )),
                    Container(
                        child: (logic.orderState.value != 'TO_SHIP' &&
                                logic.orderState.value != 'COMPLETED')
                            ? Container(
                                alignment: Alignment.topLeft,
                                padding: const EdgeInsets.all(12),
                                margin: const EdgeInsets.only(top: 12),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                        margin:
                                            const EdgeInsets.only(right: 12),
                                        child: logic.orderState.value == 'VOID'
                                            ? MaterialButton(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        side: BorderSide(
                                                            color:
                                                                Color(
                                                                    0xFFCDCDCD),
                                                            width: 1,
                                                            style:
                                                                BorderStyle
                                                                    .solid),
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20))),
                                                child: const Text('删除订单'),
                                                onPressed: () async {
                                                  logic.getOrderList(
                                                      'O20220915200200498');
                                                },
                                              )
                                            : null),
                                    MaterialButton(
                                      shape: const RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: Color(0xFF96CC39),
                                              width: 1,
                                              style: BorderStyle.solid),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                      textColor: const Color(0xFF96CC39),
                                      child: Text(
                                          logic.orderState.value == "UNPAID"
                                              ? "付款"
                                              : "确认收货"),
                                      onPressed: () {},
                                    )
                                  ],
                                ),
                              )
                            : null)
                  ],
                ))));
  }
}
