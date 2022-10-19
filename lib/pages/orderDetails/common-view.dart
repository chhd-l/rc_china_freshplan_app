import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rc_china_freshplan_app/common/values/colors.dart';

import '../../common/router/app_router.dart';
import '../../common/util/order_util.dart';
import '../../common/widgets/factor.dart';
import '../orderList/common-view.dart';

Widget orderStep(int step) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      orderStepItem('1', '买家付款', isCompleted: step >= 1),
      orderStepItem('2', '商家发货', isCompleted: step >= 2),
      orderStepItem('3', '交易完成', showLine: false, isCompleted: step == 3),
    ],
  );
}

Widget orderStepItem(String title, String subTitle,
    {bool? showLine = true, bool? isCompleted = false}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Container(
            width: 17,
            height: 17,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(17)),
                color: isCompleted == true ? AppColors.tint : Colors.white,
                border:
                    Border.all(color: const Color.fromRGBO(216, 216, 216, 1))),
            child: Text(
              title,
              style: textSyle700(
                  color: isCompleted == true
                      ? Colors.white
                      : const Color.fromRGBO(151, 151, 151, 1),
                  fontSize: 12),
            ),
          ),
          showLine == true
              ? Container(
                  width: 120,
                  height: 1,
                  decoration: BoxDecoration(
                      color: isCompleted == true
                          ? AppColors.tint
                          : const Color.fromRGBO(233, 233, 233, 1)),
                )
              : Container()
        ],
      ),
      const SizedBox(height: 8),
      Container(
        transform: Matrix4.translationValues(-15, 0, 0),
        child: Text(subTitle,
            style: textSyle400(
                color: isCompleted == true
                    ? AppColors.primaryText
                    : AppColors.text999)),
      )
    ],
  );
}

returnTitleText(String type) {
  String title = '';
  String subTitle = '';
  Widget child = Container();
  if (type == 'UNPAID') {
    title = '等待买家付款';
    subTitle = '请于订单创建后30分钟内付款,超时订单将自动关闭';
    child = orderStep(0);
  } else if (type == 'TO_SHIP') {
    title = '等待商家发货';
    subTitle = '商家会在七天内发货';
    child = orderStep(1);
  } else if (type == 'SHIPPED') {
    title = '商家已发货';
    subTitle = '商品正在路上，请耐心等待';
    child = orderStep(2);
  } else if (type == 'COMPLETED') {
    title = '交易完成';
    subTitle = '交易已完成';
    child = orderStep(3);
  } else {
    title = '交易关闭';
    subTitle = '超时未付款，订单自动取消';
  }
  return {"title": title, "subTitle": subTitle, "child": child};
}

Widget buildOrderStateView(orderState) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(returnTitleText(orderState)["title"],
            textAlign: TextAlign.left,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        Text(returnTitleText(orderState)["subTitle"],
            style: const TextStyle(color: Color(0xFF666666), fontSize: 12)),
        const SizedBox(height: 24),
        returnTitleText(orderState)["child"],
      ],
    ),
  );
}

Widget buildOrderInfoView(lineItem, productPrice, discountsPrice, totalPrice) {
  return Container(
    alignment: Alignment.topLeft,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('订单信息', style: TextStyle(fontSize: 15)),
        const Divider(color: Color.fromARGB(255, 231, 231, 231)),
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: lineItem.length,
            itemBuilder: (BuildContext ctx, int i) {
              var item = lineItem[i];
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item['spuName'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            Text('X ${item['num']}',
                                style: const TextStyle(
                                    color: Color(0xFF666666), fontSize: 12)),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 12),
                          child: Text('￥${item["price"]}',
                              style: const TextStyle(
                                  color: Color(0xFF666666), fontSize: 12)),
                        )
                      ],
                    ),
                  )
                ],
              );
            }),
        Container(
          margin: const EdgeInsets.only(bottom: 12, top: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('商品金额',
                  style: TextStyle(
                    color: Color(0xFF666666),
                  )),
              Text('¥$productPrice.00',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        Container(
            child: discountsPrice != '0'
                ? Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('促销折扣',
                            style: TextStyle(
                              color: Color(0xFF666666),
                            )),
                        Text('-¥$discountsPrice.00',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ))
                : null),
        Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('运费',
                    style: TextStyle(
                      color: Color(0xFF666666),
                    )),
                Text('¥$discountsPrice.00',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            )),
        const Divider(color: Color.fromARGB(255, 231, 231, 231)),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text('合计：'),
            Text(' ￥$totalPrice.00',
                style: const TextStyle(
                    color: Color(0xFFD49D28),
                    fontSize: 17,
                    fontWeight: FontWeight.bold)),
          ],
        )
      ],
    ),
  );
}

Widget buildOrderPayInfoView(
    orderNumber, subscriptionNo, payWay, payTime, createTime, remark) {
  return Container(
    alignment: Alignment.topLeft,
    padding: const EdgeInsets.all(12),
    margin: const EdgeInsets.symmetric(vertical: 12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text('配送方式',
                style: TextStyle(
                  color: Color(0xFF666666),
                )),
            Text('快递'),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('订单编号', style: TextStyle(color: Color(0xFF666666))),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(orderNumber),
                Container(
                    margin: const EdgeInsets.only(left: 2),
                    child: GestureDetector(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: orderNumber));
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
        ),
        const SizedBox(height: 12),
        subscriptionNo != null && subscriptionNo != ''
            ? Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('计划编号',
                        style: TextStyle(color: Color(0xFF666666))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(subscriptionNo),
                        Container(
                            margin: const EdgeInsets.only(left: 2),
                            child: GestureDetector(
                              onTap: () {
                                Clipboard.setData(
                                    ClipboardData(text: subscriptionNo));
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
                ))
            : Container(),
        payWay != null && payWay != ''
            ? Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('付款方式',
                        style: TextStyle(
                          color: Color(0xFF666666),
                        )),
                    Text(payWay),
                  ],
                ))
            : Container(),
        payWay != null && payWay != ''
            ? Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('付款时间',
                        style: TextStyle(
                          color: Color(0xFF666666),
                        )),
                    Text(payTime != ''
                        ? DateFormat('yyyy-MM-dd HH:mm:ss')
                            .format(DateTime.parse(payTime))
                        : payTime),
                  ],
                ))
            : Container(),
        Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('创建时间',
                    style: TextStyle(
                      color: Color(0xFF666666),
                    )),
                Text(payTime != ''
                    ? DateFormat('yyyy-MM-dd HH:mm:ss')
                        .format(DateTime.parse(createTime))
                    : createTime),
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
              hintText: remark,
              hintStyle: const TextStyle(color: Colors.black, fontSize: 14),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none),
              filled: true,
              fillColor: const Color(0xfff6f6f6)),
        )
      ],
    ),
  );
}

Widget buildOrderOperatorView(
    orderState, totalPrice, context, delivery, orderNum, order) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    width: double.infinity,
    decoration: const BoxDecoration(
      color: Colors.white,
    ),
    child: orderOperatorItem(
        orderState, totalPrice, context, delivery, orderNum, order),
  );
}

Widget orderOperatorItem(
    orderState, totalPrice, context, delivery, orderNum, order) {
  switch (orderState) {
    case "UNPAID":
      return Row(
        children: [
          Text('合计：',
              style: textSyle400(fontSize: 15, color: AppColors.text333)),
          Expanded(
              child: Text('￥$totalPrice.00',
                  style: textSyle400(
                      fontSize: 16,
                      color: const Color.fromRGBO(212, 157, 40, 1)))),
          titleButton(
            '去支付',
            () {
              OrderUtil.orderPay(order);
            },
            width: 114,
            height: 36,
            isCircle: true,
            bgColor: Colors.white,
            fontColor: AppColors.tint,
            borderColor: AppColors.tint,
          )
        ],
      );
    case "TO_SHIP":
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          titleButton('催发货', () {
            OrderUtil.toShipTip(context);
          },
              borderColor: const Color.fromRGBO(195, 195, 195, 1),
              fontColor: AppColors.primaryText,
              width: 96,
              height: 36,
              isCircle: true,
              bgColor: Colors.white)
        ],
      );
    case "SHIPPED":
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          titleButton(
              order["invoice"]["status"] == 'DELIVERY_STATE' ||
                      order["invoice"]["status"] == 'PRINT_STATE'
                  ? '查看发票'
                  : '申请开票', () {
            Get.toNamed(AppRoutes.invoiceDetail, arguments: orderNum);
          },
              borderColor: const Color.fromRGBO(195, 195, 195, 1),
              fontColor: AppColors.primaryText,
              width: 114,
              height: 36,
              isCircle: true,
              bgColor: Colors.white),
          const SizedBox(width: 10),
          titleButton(
            '确认收货',
            () async {
              await OrderUtil.completeOrder(orderNum);
            },
            width: 114,
            height: 36,
            isCircle: true,
            bgColor: Colors.white,
            fontColor: AppColors.tint,
            borderColor: AppColors.tint,
          )
        ],
      );
    case "COMPLETED":
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          titleButton('查看物流', () {
            showOrderDeliveryBottomSheet(context, delivery);
          },
              borderColor: const Color.fromRGBO(195, 195, 195, 1),
              fontColor: AppColors.primaryText,
              width: 114,
              height: 36,
              isCircle: true,
              bgColor: Colors.white),
          const SizedBox(width: 10),
          titleButton(
              order["invoice"]["status"] == 'DELIVERY_STATE' ||
                      order["invoice"]["status"] == 'PRINT_STATE'
                  ? '查看发票'
                  : '申请开票', () {
            Get.toNamed(AppRoutes.invoiceDetail, arguments: orderNum);
          },
              borderColor: const Color.fromRGBO(195, 195, 195, 1),
              fontColor: AppColors.primaryText,
              width: 114,
              height: 36,
              isCircle: true,
              bgColor: Colors.white),
        ],
      );
    case "VOID":
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          titleButton('删除订单', () async {
            await OrderUtil.deleteOrder(orderNum);
          },
              borderColor: const Color.fromRGBO(195, 195, 195, 1),
              fontColor: AppColors.primaryText,
              width: 114,
              height: 36,
              isCircle: true,
              bgColor: Colors.white),
        ],
      );
  }
  return Container();
}

Widget buildDeliveryInfoView(
    receiverName, phone, province, city, region, detail, delivery) {
  print(1111);
  print(delivery);
  return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          delivery != null && delivery != 'null' && delivery != null
              ? SizedBox(
                  height: 200,
                  child: orderDeliveryItem(delivery),
                )
              : Container(),
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 12),
                child: Image.asset('assets/images/address.png'),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('$receiverName ',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15)),
                      Text(' $phone',
                          style: const TextStyle(
                              color: Color(0xFF666666), fontSize: 12)),
                    ],
                  ),
                  Text('$province $city $region $detail'),
                ],
              )
            ],
          )
        ],
      ));
}
