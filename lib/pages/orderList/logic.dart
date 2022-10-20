import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/common/util/event_bus.dart';

import 'package:rc_china_freshplan_app/common/util/order_util.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:rc_china_freshplan_app/common/values/const.dart';

class OrderLogic extends GetxController {
  var tagType = 'ALL'.obs;
  var orderLists = [].obs;
  RxInt curPageNum = 1.obs;
  RxInt total = 0.obs;
  RxBool showSearchBtn=false.obs;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  TextEditingController nameOrNumController=TextEditingController();
  FocusNode nameOrNumFocus=FocusNode();

  @override
  void onInit() {
    var args = Get.arguments ?? 'ALL';
    onChangeTagType(args.toString());

    EventBus().addListener(updateOrder, (arg) {
      getOrderList(curPageNum.value, tagType.value);
    });

    nameOrNumFocus.addListener(() {
      showSearchBtn.value = nameOrNumFocus.hasFocus;
    });

    super.onInit();
  }

  @override
  void onClose(){
    refreshController.dispose();
    nameOrNumController.dispose();
    nameOrNumFocus.dispose();
    super.onClose();
  }

  void getOrderList(int offset, String orderState) {
    OrderUtil.getOrders(offset, orderState,nameOrNumController.text).then((value) {
      refreshController.loadComplete();
      refreshController.refreshCompleted();
      if (value != false) {
        orderLists.clear();
        orderLists.addAll(value["records"]);
        total.value = value["total"];
        update();
      } else {
        orderLists.clear();
      }
    });
  }

  void onChangeTagType(String type) {
    tagType.value = type;
    getOrderList(curPageNum.value, type);
  }

  //上拉刷新
  void onRefresh() async {
    curPageNum.value = 1;
    getOrderList(curPageNum.value, tagType.value);
  }

  //下拉加载更多
  void onLoading() {
    if (total.value > curPageNum.value * 10) {
      curPageNum.value += 1;
      getOrderList(curPageNum.value, tagType.value);
    } else {
      refreshController.loadNoData();
    }
  }
}
