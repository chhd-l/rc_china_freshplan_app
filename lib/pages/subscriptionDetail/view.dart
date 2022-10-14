import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rc_china_freshplan_app/common/util/utils.dart';
import 'package:rc_china_freshplan_app/common/values/colors.dart';
import 'package:rc_china_freshplan_app/common/widgets/factor.dart';
import 'package:rc_china_freshplan_app/common/router/app_router.dart';
import 'package:rc_china_freshplan_app/common/widgets/textFields.dart';
import 'package:rc_china_freshplan_app/pages/checkout/checkout-widget-view.dart';
import 'package:rc_china_freshplan_app/pages/createPet/common-widget-view.dart';
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
                buildSubPetView({}),
                const SizedBox(height: 15),
                buildSubPlanProductView(null, [
                  {"variants": {}}
                ]),
                const SizedBox(height: 15),
                buildSubRecommendProductView([
                  {"variants": {}},
                  {"variants": {}}
                ]),
                const SizedBox(height: 15),
                buildSubDeliveryHouseView('2022-08-23'),
                const SizedBox(height: 15),
                buildSubPayInfoView(''),
                const SizedBox(height: 15),
              ])),
        ),
      ),
    );
  }
}
