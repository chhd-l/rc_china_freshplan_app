import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/common/router/app_router.dart';
import 'package:rc_china_freshplan_app/common/widgets/textFields.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
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
        backgroundColor: const Color.fromARGB(255, 249, 249, 249),
        body: Column(children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(12),
            child: textFiled(borderRadius: 45),
          ),
          Obx(() => Row(
                children: [
                  Expanded(
                      child: listTabItem(() {
                    logic.onChangeTagType('ALL');
                  }, logic.tagType.value == 'ALL', '全部')),
                  Expanded(
                      child: listTabItem(() {
                    logic.onChangeTagType('UNPAID');
                  }, logic.tagType.value == 'UNPAID', '待付款')),
                  Expanded(
                      child: listTabItem(() {
                    logic.onChangeTagType('TO_SHIP');
                  }, logic.tagType.value == 'TO_SHIP', '待发货')),
                  Expanded(
                      child: listTabItem(() {
                    logic.onChangeTagType('SHIPPED');
                  }, logic.tagType.value == 'SHIPPED', '待收货')),
                ],
              )),
          Expanded(
              child: SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: true,
                  controller: logic.refreshController,
                  onRefresh: logic.onRefresh,
                  onLoading: logic.onLoading,
                  child: SingleChildScrollView(
                      child: Obx(() => logic.orderLists.isEmpty
                          ? noOrderListView()
                          : Container(
                              padding: const EdgeInsets.only(
                                  top: 18, left: 12, right: 12),
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: logic.orderLists.length,
                                itemBuilder: (BuildContext ctx, int i) {
                                  var order = logic.orderLists[i];
                                  return orderListItem(order, ctx);
                                },
                              )))))),
        ]));
  }
}
