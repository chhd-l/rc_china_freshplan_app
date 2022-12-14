import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:rc_china_freshplan_app/common/util/utils.dart';
import 'package:rc_china_freshplan_app/common/values/colors.dart';
import 'package:rc_china_freshplan_app/common/widgets/factor.dart';
import 'package:rc_china_freshplan_app/pages/planDetail/plan_item_view.dart';

import 'logic.dart';
import 'state.dart';

class PlanDetailPage extends StatelessWidget {
  PlanDetailPage({super.key});

  final PlanDetailLogic logic = Get.put(PlanDetailLogic());
  final PlanDetailState state = Get.find<PlanDetailLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: commonAppBar('计划详情', bgColor: AppColors.bgLinearGradient1),
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
                    Visibility(
                        visible: logic.planDetail.value["status"] == 'VOID',
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/plan-cancel-icon.png'),
                              const SizedBox(width: 10),
                              Text('计划已取消',
                                  style: textSyle700(
                                      fontSize: 16, color: Colors.white))
                            ],
                          ),
                        )),
                    buildPlanProductView(logic.planDetail.value, context,
                        logic.planDetail.value["price"] ?? {}),
                    buildDeliveryInfoView(
                        logic.planDetail.value["status"] == 'VOID',
                        handleDateFromApi(
                            logic.planDetail.value["createNextDeliveryTime"]),
                        logic.planDetail.value["address"] ?? {}),
                    Visibility(
                      visible: logic.planDetail.value["status"] != 'VOID',
                      child: Text(
                        '温馨提示: 修改地址以外其他信息请联系人工客服',
                        style:
                            textSyle700(fontSize: 13, color: AppColors.text999),
                      ),
                    ),
                    const SizedBox(height: 15),
                    buildHistoryOrderView(
                        logic.planDetail.value["completedDeliveries"] ?? []),
                  ])),
            ),
          ),
        ));
  }
}
