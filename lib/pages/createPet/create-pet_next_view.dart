import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rc_china_freshplan_app/common/values/colors.dart';
import 'package:rc_china_freshplan_app/common/widgets/factor.dart';
import 'package:rc_china_freshplan_app/common/widgets/textFields.dart';

import 'common-widget-view.dart';
import 'logic.dart';
import 'state.dart';

class CreatePetNextPage extends StatelessWidget {
  CreatePetNextPage({super.key});

  final CreatePetLogic logic = Get.put(CreatePetLogic());
  final CreatePetState state = Get.find<CreatePetLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: commonAppBar('创建宠物档案'),
        body: SafeArea(
          child: Column(children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                    right: 16.w, left: 16.w, top: 40.w, bottom: 16.h),
                child: Column(children: [
                  commonTitle('${logic.petNameController.text}近期的体重',
                      subTitle: '（kg）'),
                  Padding(
                    padding: const EdgeInsets.only(top: 26, bottom: 32),
                    child: textFiled(
                        controller: logic.recentWeightController,
                        keyboardType: TextInputType.number),
                  ),
                  commonTitle('${logic.petNameController.text}近期状态'),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(() => Expanded(
                                child: statusBox(
                                    state.recentPosture.value == 'EMACIATED',
                                    'thin',
                                    '瘦弱', () {
                              state.recentPosture.value = 'EMACIATED';
                            }))),
                        Obx(() => Expanded(
                                child: statusBox(
                                    state.recentPosture.value == 'STANDARD',
                                    'standard',
                                    '标准', () {
                              state.recentPosture.value = 'STANDARD';
                            }))),
                        Obx(() => Expanded(
                                child: statusBox(
                                    state.recentPosture.value == 'OBESITY',
                                    'overweight',
                                    '超重', () {
                              state.recentPosture.value = 'OBESITY';
                            }))),
                      ],
                    ),
                  ),
                  commonTitle('${logic.petNameController.text}近期成年目标体重',
                      subTitle: '（kg）'),
                  Padding(
                    padding: const EdgeInsets.only(top: 26, bottom: 32),
                    child: textFiled(
                        controller: logic.targetWeightController,
                        keyboardType: TextInputType.number),
                  ),
                  commonTitle('${logic.petNameController.text}近期的健康情况'),
                  Padding(
                    padding: const EdgeInsets.only(top: 26, bottom: 32),
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: logic.healthList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: GestureDetector(
                                onTap: () {
                                  logic.changeRecentHealth(index);
                                },
                                child: Obx(() => Container(
                                      height: 50,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: state.recentHealth.value
                                                  .contains(
                                                      logic.healthList[index]
                                                          ['value'])
                                              ? AppColors.tint
                                              : const Color.fromRGBO(
                                                  246, 246, 246, 1),
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(15),
                                          )),
                                      child: Text(
                                          logic.healthList[index]['name'],
                                          style: textSyle700(
                                              fontSize: 15,
                                              color: state.recentHealth.value
                                                      .contains(logic
                                                              .healthList[index]
                                                          ['value'])
                                                  ? Colors.white
                                                  : AppColors.primaryText)),
                                    ))),
                          );
                        }),
                  ),
                ]),
              ),
            ),
            fixBottomContainer(
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  titleButton('上一步', () {},
                      width: 145,
                      bgColor: const Color.fromRGBO(217, 217, 217, 1)),
                  titleButton('推荐食谱', () {
                    logic.recommendedRecipes();
                  }, width: 145)
                ],
              ),
            )
          ]),
        ));
  }
}
