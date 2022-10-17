import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rc_china_freshplan_app/common/util/utils.dart';
import 'package:rc_china_freshplan_app/common/values/colors.dart';
import 'package:rc_china_freshplan_app/common/widgets/factor.dart';
import 'package:rc_china_freshplan_app/pages/subscriptionDetail/subscription-item-view.dart';

import 'logic.dart';
import 'state.dart';

class SubscriptionDetailPage extends StatelessWidget {
  SubscriptionDetailPage({super.key});

  final SubscriptionDetailLogic logic = Get.put(SubscriptionDetailLogic());
  final SubscriptionDetailState state =
      Get.find<SubscriptionDetailLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: commonAppBar('订阅详情', bgColor: AppColors.bgLinearGradient1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.all(15),
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
                buildSubPetView(logic.subscriptionDetail["pet"] ?? {}),
                buildSubPlanProductView(logic.subscriptionDetail["no"],
                    logic.subscriptionDetail["productList"] ?? []),
                Visibility(
                    visible:
                        (logic.subscriptionDetail["benefits"] ?? []).length > 0,
                    child: buildSubRecommendProductView(
                        logic.subscriptionDetail["benefits"] ?? [])),
                buildSubDeliveryHouseView(
                    handleDateFromApi(
                        logic.subscriptionDetail["createNextDeliveryTime"]),
                    logic.subscriptionDetail["status"] == 'VOID',
                    logic.subscriptionDetail["id"]),
                buildSubPayInfoView(
                    logic.subscriptionDetail["source"],
                    logic.subscriptionDetail["consumer"] != null
                        ? logic.subscriptionDetail["consumer"]["phone"]
                        : ''),
              ])),
        ),
      ),
    );
  }
}
