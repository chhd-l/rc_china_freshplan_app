import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rc_china_freshplan_app/api/order/index.dart';
import 'package:rc_china_freshplan_app/common/util/order_util.dart';
import 'package:rc_china_freshplan_app/common/values/colors.dart';
import 'package:rc_china_freshplan_app/common/widgets/factor.dart';

import '../../common/router/app_router.dart';

Widget noOrderListView() {
  return Container(
    margin: const EdgeInsets.only(top: 38),
    child: Column(
      children: [
        Image.network(
          'https://dtcdata.oss-cn-shanghai.aliyuncs.com/asset/image/image 43.png',
          width: 158,
          height: 158,
          fit: BoxFit.cover,
        ),
        const Text('啥也没有~',
            style: TextStyle(
              color: Color(0xFF666666),
            )),
        Container(
          margin: const EdgeInsets.only(top: 20),
          width: 156,
          height: 36,
          child: MaterialButton(
            shape: const RoundedRectangleBorder(
                side: BorderSide(
                    color: Color(0xFF96CC39),
                    width: 1,
                    style: BorderStyle.solid),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            textColor: const Color(0xFF96CC39),
            child: const Text('开始定制'),
            onPressed: () async {
              Get.toNamed(AppRoutes.choosePet);
            },
          ),
        )
      ],
    ),
  );
}

returnType(String type) {
  if (type == 'UNPAID') {
    return '待付款';
  } else if (type == 'TO_SHIP') {
    return '待发货';
  } else if (type == 'SHIPPED') {
    return '待收货';
  } else if (type == 'COMPLETED') {
    return '交易成功';
  } else {
    return '交易关闭';
  }
}

Widget orderListItem(order, context) {
  return GestureDetector(
    onTap: () {
      Get.toNamed(AppRoutes.orderDetails, arguments: order['orderNumber']);
    },
    child: Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: const [
          BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, 6.0), //阴影xy轴偏移量
              blurRadius: 15.0, //阴影模糊程度
              spreadRadius: 1.0 //阴影扩散程度
              )
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(returnType(order['orderState']['orderState']),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
              Text(
                  '创建时间:${order['orderState']['createdAt'] != '' ? DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.parse(order['orderState']['createdAt'])) : order['orderState']['createdAt']}',
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: Color(0xFF666666),
                    fontSize: 12,
                  )),
            ],
          ),
          Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              height: 70,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: order['lineItem'].length ?? 0,
                  itemExtent: 80,
                  cacheExtent: 160,
                  itemBuilder: (BuildContext ctxs, int index) {
                    List item = order['lineItem'];
                    return Container(
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFf1f1f1),
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                      child: Image.network(
                        item[index]['pic'] as String,
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    );
                  })),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                const Text('商品合计',
                    style: TextStyle(color: Color(0xFF666666), fontSize: 13)),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text('¥',
                          style: TextStyle(
                              fontSize: 8, fontWeight: FontWeight.bold)),
                      Text('${order['orderPrice']['totalPrice']}.00',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: Color.fromARGB(255, 231, 231, 231)),
          orderOperateBtn(order['orderState']['orderState'], false,
              order['orderNumber'], context, order["delivery"], order),
        ],
      ),
    ),
  );
}

Widget moreOperate(bool isInvoice) {
  var showMore = false;
  return SizedBox(
    child: Stack(children: [
      GestureDetector(
        onTap: () {
          showMore = true;
        },
        child: Text('更多',
            style: textSyle400(color: const Color.fromRGBO(57, 57, 58, 1))),
      ),
      Positioned(
          top: 10,
          left: 25,
          height: 25,
          child: Visibility(
              visible: showMore,
              child: Container(
                width: 80,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/invoice-tip.png'))),
                child: Text(isInvoice ? '查看发票' : '申请开票'),
              )))
    ]),
  );
}

Widget invoiceBtn(bool isInvoice) {
  return titleButton(isInvoice ? '查看发票' : '申请开票', () {},
      bgColor: Colors.white,
      width: 116,
      height: 34,
      isCircle: true,
      borderColor: const Color.fromARGB(255, 205, 205, 205),
      fontColor: AppColors.primaryText);
}

Widget orderOperateBtn(String orderState, bool isInvoice, String orderNum,
    context, delivery, order) {
  switch (orderState) {
    case 'UNPAID':
      return Row(
        children: [
          Expanded(child: moreOperate(isInvoice)),
          titleButton('取消', () async {
            await OrderEndPoint.cancelOrder(orderNum);
          },
              bgColor: Colors.white,
              width: 90,
              height: 34,
              isCircle: true,
              borderColor: const Color.fromARGB(255, 205, 205, 205),
              fontColor: AppColors.primaryText),
          const SizedBox(width: 10),
          titleButton('付款', () {
            OrderUtil.orderPay(order);
          },
              width: 90,
              height: 34,
              isCircle: true,
              bgColor: Colors.white,
              borderColor: AppColors.tint,
              fontColor: AppColors.tint)
        ],
      );
    case 'TO_SHIP':
      return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        moreOperate(true),
        invoiceBtn(isInvoice),
        const SizedBox(width: 10),
        titleButton('催发货', () {
          OrderUtil.toShipTip(context);
        },
            width: 90,
            height: 34,
            isCircle: true,
            bgColor: Colors.white,
            borderColor: AppColors.tint,
            fontColor: AppColors.tint),
      ]);
    case 'SHIPPED':
      return Row(children: [
        Expanded(child: moreOperate(isInvoice)),
        titleButton('查看物流', () {
          showOrderDeliveryBottomSheet(context, delivery);
        },
            bgColor: Colors.white,
            width: 100,
            height: 34,
            isCircle: true,
            borderColor: const Color.fromARGB(255, 205, 205, 205),
            fontColor: AppColors.primaryText),
        const SizedBox(width: 10),
        titleButton('确认收货', () async {
          await OrderUtil.completeOrder(orderNum);
        },
            width: 100,
            height: 34,
            isCircle: true,
            bgColor: Colors.white,
            borderColor: AppColors.tint,
            fontColor: AppColors.tint)
      ]);
    case 'COMPLETED':
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          titleButton('查看物流', () {
            showOrderDeliveryBottomSheet(context, delivery);
          },
              bgColor: Colors.white,
              width: 100,
              height: 34,
              isCircle: true,
              borderColor: const Color.fromARGB(255, 205, 205, 205),
              fontColor: AppColors.primaryText),
          const SizedBox(width: 10),
          invoiceBtn(isInvoice),
        ],
      );
    case "VOID":
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          titleButton('删除订单', () async {
            await OrderUtil.deleteOrder(orderNum);
          },
              bgColor: Colors.white,
              width: 100,
              height: 34,
              isCircle: true,
              borderColor: const Color.fromARGB(255, 205, 205, 205),
              fontColor: AppColors.primaryText),
        ],
      );
  }
  return Container();
}

showOrderDeliveryBottomSheet(BuildContext context, delivery) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        padding: const EdgeInsets.only(top: 16, left: 10, right: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Text(
                  '快递详情',
                  style: textSyle400(fontSize: 18),
                  textAlign: TextAlign.center,
                )),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(
                    Icons.close,
                    size: 30,
                    color: Colors.black,
                  ),
                )
              ],
            ),
            const SizedBox(height: 17),
            Expanded(
                child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
              ),
              padding: const EdgeInsets.all(12),
              child: orderDeliveryItem(delivery),
            ))
          ],
        ),
      );
    },
    backgroundColor: const Color.fromRGBO(242, 242, 242, 1),
    elevation: 10,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
    ),
  );
}

Widget orderDeliveryItem(delivery) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.network(
                delivery['shippingCompanyImg'] as String,
                width: 24,
                height: 24,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 10),
              Text(
                delivery["shippingCompany"],
                style:
                    textSyle400(color: const Color.fromRGBO(148, 148, 148, 1)),
              ),
              const SizedBox(width: 10),
              Text(
                delivery["trackingId"],
                style:
                    textSyle400(color: const Color.fromRGBO(148, 148, 148, 1)),
              )
            ],
          ),
          GestureDetector(
            onTap: () {
              Clipboard.setData(ClipboardData(text: delivery["trackingId"]));
            },
            child: const Icon(
              Icons.library_books,
              color: Color(0xFF96CC39),
              size: 14,
            ),
          )
        ],
      ),
      const SizedBox(height: 10),
      Expanded(
          child: ListView.builder(
        itemBuilder: (context, index) {
          return IntrinsicHeight(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    transform: Matrix4.translationValues(0, 5, 0),
                    decoration: BoxDecoration(
                        color: index == 0
                            ? AppColors.tint
                            : const Color.fromRGBO(217, 217, 217, 1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8))),
                  ),
                  Expanded(
                      child: index != delivery["deliveryItems"].length - 1
                          ? Container(
                              width: 1,
                              transform: Matrix4.translationValues(0, 5, 0),
                              decoration: const BoxDecoration(
                                  color: Color.fromRGBO(217, 217, 217, 1)),
                            )
                          : Container())
                ],
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(delivery["deliveryItems"][index]["status"],
                          style: textSyle400(
                              fontSize: 13,
                              color: index == 0
                                  ? AppColors.primaryText
                                  : AppColors.text999)),
                      const SizedBox(width: 10),
                      Text(delivery["deliveryItems"][index]["time"],
                          style: textSyle400(
                              fontSize: 11,
                              color: index == 0
                                  ? AppColors.primaryText
                                  : AppColors.text999))
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                      width: 350,
                      child: Text(
                        delivery["deliveryItems"][index]["context"],
                        style: textSyle400(
                            fontSize: 12,
                            color: index == 0
                                ? AppColors.primaryText
                                : AppColors.text999),
                        maxLines: 4,
                      )),
                  const SizedBox(height: 30),
                ],
              )
            ],
          ));
        },
        itemCount: delivery["deliveryItems"] != null
            ? delivery["deliveryItems"].length
            : 0,
      ))
    ],
  );
}

Widget listTabItem(VoidCallback pressed, bool isSelected, String title) {
  return GestureDetector(
    onTap: () {
      pressed();
    },
    child: Container(
      padding: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: isSelected
              ? const BorderSide(color: Color(0xFF96CC39), width: 2)
              : BorderSide.none,
        ),
      ),
      child: Text(title,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: isSelected ? const Color(0xFF96CC39) : Colors.black,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 15)),
    ),
  );
}
