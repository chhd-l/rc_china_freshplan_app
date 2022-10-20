import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/common/widgets/factor.dart';
import 'package:rc_china_freshplan_app/common/widgets/text_fields.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'common_view.dart';
import 'logic.dart';

class OrderList extends StatelessWidget {
  OrderList({Key? key}) : super(key: key);

  final OrderLogic logic = Get.put(OrderLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: commonAppBar('订单列表'),
        backgroundColor: const Color.fromARGB(255, 249, 249, 249),
        body: Column(children: [
          Container(
            height: 56,
            color: Colors.white,
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                    child: textFiled(
                        borderRadius: 45,
                        controller: logic.nameOrNumController,
                        focusNode: logic.nameOrNumFocus,
                        hintText: '输入商品名称/订单编号搜索订单',
                        verticalPadding: 8,
                        hintStyle: textSyle700(
                            fontSize: 14,
                            color: const Color.fromRGBO(202, 203, 206, 1)),
                        icon: 'assets/images/search-icon.png')),
                Obx(() => Visibility(
                    visible: logic.showSearchBtn.value ||
                        logic.nameOrNumController.text != '',
                    child: titleButton('搜索', () {
                      logic.curPageNum.value = 1;
                      logic.getOrderList(
                          logic.curPageNum.value, logic.tagType.value);
                    }, width: 80, isCircle: true)))
              ],
            ),
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
