import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rc_china_freshplan_app/common/router/app_router.dart';
import 'package:rc_china_freshplan_app/common/util/order_util.dart';
import 'package:rc_china_freshplan_app/data/order.dart';
import 'common-view.dart';
import 'logic.dart';

class OrderList extends StatefulWidget {
  const OrderList({Key? key}) : super(key: key);

  @override
  _OrderListWidgetState createState() => _OrderListWidgetState();
}

class _OrderListWidgetState extends State<OrderList> {
  final OrderLogic logic = Get.put(OrderLogic());
  Widget build(BuildContext context) {
    var args = Get.arguments;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (args != null && args != '') {
        logic.onChangeTagType(args.toString());
        logic.getOrderList(args.toString());
      } else {
        logic.onChangeTagType('ALL');
        logic.getOrderList('ALL');
      }
    });

    return Scaffold(
        appBar: AppBar(
          title: const Text('订单列表'),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: GestureDetector(
            child: const Icon(
              Icons.arrow_back_ios,
            ),
            onTap: () {
              Get.toNamed(AppRoutes.account);
            },
          ),
        ),
        body: SingleChildScrollView(
            child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 249, 249, 249),
                ),
                child: Obx(() => Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: GestureDetector(
                              onTap: (() {
                                logic.onChangeTagType('ALL');
                                logic.getOrderList('ALL');
                              }),
                              child: Container(
                                padding: const EdgeInsets.only(bottom: 12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                    bottom: logic.tagType.value == 'ALL'
                                        ? const BorderSide(
                                            color: Color(0xFF96CC39), width: 2)
                                        : BorderSide.none,
                                  ),
                                ),
                                child: Text('全部',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: logic.tagType.value == 'ALL'
                                            ? const Color(0xFF96CC39)
                                            : Colors.black,
                                        fontWeight: logic.tagType.value == 'ALL'
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                        fontSize: 15)),
                              ),
                            )),
                            Expanded(
                                child: GestureDetector(
                              onTap: (() {
                                logic.onChangeTagType('UNPAID');
                                logic.getOrderList('UNPAID');
                              }),
                              child: Container(
                                padding: const EdgeInsets.only(bottom: 12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                    bottom: logic.tagType.value == 'UNPAID'
                                        ? const BorderSide(
                                            color: Color(0xFF96CC39), width: 2)
                                        : BorderSide.none,
                                  ),
                                ),
                                child: Text('待付款',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: logic.tagType.value == 'UNPAID'
                                            ? const Color(0xFF96CC39)
                                            : Colors.black,
                                        fontWeight:
                                            logic.tagType.value == 'UNPAID'
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                        fontSize: 15)),
                              ),
                            )),
                            Expanded(
                                child: GestureDetector(
                              onTap: (() {
                                logic.onChangeTagType('TO_SHIP');
                                logic.getOrderList('TO_SHIP');
                              }),
                              child: Container(
                                padding: const EdgeInsets.only(bottom: 12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                    bottom: logic.tagType.value == 'TO_SHIP'
                                        ? const BorderSide(
                                            color: Color(0xFF96CC39), width: 2)
                                        : BorderSide.none,
                                  ),
                                ),
                                child: Text('待发货',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: logic.tagType.value == 'TO_SHIP'
                                            ? const Color(0xFF96CC39)
                                            : Colors.black,
                                        fontWeight:
                                            logic.tagType.value == 'TO_SHIP'
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                        fontSize: 15)),
                              ),
                            )),
                            Expanded(
                                child: GestureDetector(
                              onTap: (() {
                                logic.onChangeTagType('SHIPPED');
                                logic.getOrderList('SHIPPED');
                              }),
                              child: Container(
                                padding: const EdgeInsets.only(bottom: 12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                    bottom: logic.tagType.value == 'SHIPPED'
                                        ? const BorderSide(
                                            color: Color(0xFF96CC39), width: 2)
                                        : BorderSide.none,
                                  ),
                                ),
                                child: Text('待收货',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: logic.tagType.value == 'SHIPPED'
                                            ? const Color(0xFF96CC39)
                                            : Colors.black,
                                        fontWeight:
                                            logic.tagType.value == 'SHIPPED'
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                        fontSize: 15)),
                              ),
                            )),
                          ],
                        ),
                        Container(
                            child: (logic.orderLists.length == null ||
                                    logic.orderLists.isEmpty)
                                ? noOrderListView()
                                : Container(
                                    padding: const EdgeInsets.only(
                                        top: 18, left: 12, right: 12),
                                    child: ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: logic.orderLists.length,
                                      itemBuilder: (BuildContext ctx, int i) {
                                        var order = logic.orderLists[i];
                                        return orderListItem(order,ctx);
                                      },
                                    )))
                      ],
                    )))));
  }
}
