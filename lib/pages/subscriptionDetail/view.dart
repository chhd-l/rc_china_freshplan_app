import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/common/util/utils.dart';
import 'package:rc_china_freshplan_app/common/values/colors.dart';
import 'package:rc_china_freshplan_app/common/widgets/factor.dart';
import 'package:rc_china_freshplan_app/pages/subscriptionDetail/subscription_item_view.dart';

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
              child: Obx(() => Column(children: [
                    buildSubPetView(
                        logic.subscriptionDetail.value["pet"] ?? {}),
                    buildSubPlanProductView(
                        logic.subscriptionDetail.value["no"],
                        logic.subscriptionDetail.value["productList"] ?? []),
                    Visibility(
                        visible:
                            (logic.subscriptionDetail.value["benefits"] ?? [])
                                    .length >
                                0,
                        child: buildSubRecommendProductView(
                            logic.subscriptionDetail.value["benefits"] ?? [])),
                    buildSubDeliveryHouseView(
                        handleDateFromApi(logic.subscriptionDetail
                            .value["createNextDeliveryTime"]),
                        logic.subscriptionDetail.value["status"] == 'VOID',
                        logic.subscriptionDetail.value["id"]),
                    buildSubPayInfoView(
                        logic.subscriptionDetail.value["source"],
                        logic.subscriptionDetail.value["consumer"] != null
                            ? logic.subscriptionDetail.value["consumer"]
                                ["phone"]
                            : ''),
                  ]))),
        ),
      ),
    );
  }
}
