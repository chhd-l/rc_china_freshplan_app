import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rc_china_freshplan_app/common/values/colors.dart';
import 'package:rc_china_freshplan_app/common/widgets/factor.dart';
import 'package:rc_china_freshplan_app/common/widgets/textFields.dart';
import 'package:rc_china_freshplan_app/common/router/app_router.dart';

import 'common-widget-view.dart';
import 'logic.dart';
import 'state.dart';

class CreatePetPage extends StatelessWidget {
  CreatePetPage({super.key});

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
                padding: EdgeInsets.only(right: 16.w, left: 16.w, bottom: 16.h),
                child: Obx(() => Column(children: [
                      buildProgressView(state.currentStep.value),
                      Visibility(
                          visible: state.currentStep.value == 1,
                          child: Column(
                            children: [
                              commonTitle('您的爱宠是',
                                  description: '爱宠的健康之旅，从这里开始。'),
                              const SizedBox(height: 52),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  petAvatarPick(() {
                                    logic.changeType('CAT');
                                  }, '',
                                      childAsset: 'assets/images/cat.png',
                                      pickAsset:
                                          'assets/images/pet-type-${state.type.value == 'CAT' ? 'selected' : 'select'}.png',
                                      bgColor: state.type.value == 'CAT'
                                          ? const Color.fromRGBO(
                                              255, 176, 56, 1)
                                          : const Color.fromRGBO(
                                              239, 239, 240, 1)),
                                  petAvatarPick(() {
                                    logic.changeType('DOG');
                                  }, '',
                                      childAsset: 'assets/images/dog.png',
                                      pickAsset:
                                          'assets/images/pet-type-${state.type.value == 'DOG' ? 'selected' : 'select'}.png',
                                      bgColor: state.type.value == 'DOG'
                                          ? const Color.fromRGBO(
                                              255, 176, 56, 1)
                                          : const Color.fromRGBO(
                                              239, 239, 240, 1)),
                                ],
                              ),
                            ],
                          )),
                      Visibility(
                        visible: state.currentStep.value == 2,
                        child: Column(
                          children: [
                            petAvatarPick(() {
                              logic.selectImageType();
                            }, state.avatar.value,
                                bgColor: const Color.fromRGBO(255, 176, 56, 1),
                                childAsset:
                                    'assets/images/${state.type.value == 'DOG' ? 'dog' : 'cat'}.png'),
                            const SizedBox(height: 46),
                            commonTitle('您爱宠的昵称是'),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 16, bottom: 32),
                              child: textFiled(
                                  controller: logic.petNameController,
                                  focusNode: logic.petNameFocusNode),
                            ),
                            commonTitle('您爱宠的性别'),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 16, bottom: 32),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  genderBox(state.gender.value == 'MALE', '小鲜肉',
                                      () {
                                    logic.changeGender('MALE');
                                  }),
                                  genderBox(
                                      state.gender.value == 'FEMALE', '小公主',
                                      () {
                                    logic.changeGender('FEMALE');
                                  }),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Visibility(
                        visible: state.currentStep.value == 3,
                        child: Column(
                          children: [
                            commonTitle('${state.name.value}的品种是'),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 26, bottom: 32),
                              child: Column(
                                children: [
                                  SizedBox(
                                      height: 220,
                                      child: GridView.builder(
                                          itemCount: 9,
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 3,
                                                  crossAxisSpacing: 10,
                                                  mainAxisSpacing: 10,
                                                  childAspectRatio: 2.2),
                                          itemBuilder: (context, index) {
                                            final breed =
                                                state.breedList[index];
                                            return GestureDetector(
                                                onTap: () {
                                                  logic
                                                      .selectNormalBreed(breed);
                                                },
                                                child: Container(
                                                  width: 110,
                                                  height: 20,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      color: state.breedName
                                                                  .value ==
                                                              breed["name"]
                                                          ? AppColors.tint
                                                          : AppColors.baseGray,
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              Radius.circular(
                                                                  15))),
                                                  child: Text(
                                                    breed["name"],
                                                    style: textSyle700(
                                                        fontSize: 15,
                                                        color: state.breedName
                                                                    .value ==
                                                                breed["name"]
                                                            ? Colors.white
                                                            : AppColors
                                                                .primaryText),
                                                  ),
                                                ));
                                          })),
                                  selectBox(
                                      value: state.breedName.value,
                                      onPressed: () {
                                        FocusScope.of(context)
                                            .requestFocus(FocusNode());
                                        logic.selectBreed();
                                      })
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: state.currentStep.value == 4,
                        child: Column(
                          children: [
                            commonTitle('${state.name.value}多大了',
                                subTitle: '（选择出生日期）'),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 26, bottom: 32),
                              child: selectBox(
                                  value: state.birthday.value,
                                  onPressed: () {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    logic.selectBirthday();
                                  }),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: state.currentStep.value == 5,
                        child: Column(
                          children: [
                            commonTitle('${state.name.value}绝育状态'),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 16, bottom: 32),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  genderBox(state.isSterilized == false, '未绝育',
                                      () {
                                    logic.changeIsSterilized(false);
                                  }),
                                  genderBox(state.isSterilized == true, '已绝育',
                                      () {
                                    logic.changeIsSterilized(true);
                                  }),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Visibility(
                          visible: state.currentStep.value == 6,
                          child: Column(
                            children: [
                              commonTitle('${state.name.value}近期的体重',
                                  subTitle: '（kg）'),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 26, bottom: 32),
                                child: selectBox(
                                    value: state.recentWeight.value.toString(),
                                    onPressed: () {
                                      logic.selectWeight(context, 'now');
                                    }),
                              ),
                              commonTitle('${state.name.value}近期状态'),
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 16, bottom: 32),
                                decoration: const BoxDecoration(
                                    color: AppColors.baseGray,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                        child: statusBox(
                                            state.recentPosture.value ==
                                                'EMACIATED',
                                            'thin',
                                            '瘦弱', () {
                                      state.recentPosture.value = 'EMACIATED';
                                    })),
                                    Expanded(
                                        child: statusBox(
                                            state.recentPosture.value ==
                                                'STANDARD',
                                            'standard',
                                            '标准', () {
                                      state.recentPosture.value = 'STANDARD';
                                    })),
                                    Expanded(
                                        child: statusBox(
                                            state.recentPosture.value ==
                                                'OBESITY',
                                            'overweight',
                                            '超重', () {
                                      state.recentPosture.value = 'OBESITY';
                                    })),
                                  ],
                                ),
                              ),
                              commonTitle('${state.name.value}近期成年目标体重',
                                  subTitle: '（kg）'),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 26, bottom: 32),
                                child: selectBox(
                                    value: state.targetWeight.value.toString(),
                                    onPressed: () {
                                      logic.selectWeight(context, 'target');
                                    }),
                              ),
                            ],
                          )),
                      Visibility(
                          visible: state.currentStep.value == 7,
                          child: Column(
                            children: [
                              commonTitle('${state.name.value}近期的健康情况'),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 26, bottom: 32),
                                child: ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: logic.healthList.length,
                                    itemBuilder: (context, index) {
                                      return Obx(() => Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 15),
                                            child: GestureDetector(
                                                onTap: () {
                                                  logic.changeRecentHealth(
                                                      index);
                                                },
                                                child: Container(
                                                  height: 50,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      color: state
                                                              .recentHealth.value
                                                              .contains(
                                                                  logic.healthList[
                                                                          index]
                                                                      ['value'])
                                                          ? AppColors.tint
                                                          : AppColors.baseGray,
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        Radius.circular(15),
                                                      )),
                                                  child: Text(
                                                      logic.healthList[index]
                                                          ['name'],
                                                      style: textSyle700(
                                                          fontSize: 15,
                                                          color: state
                                                                  .recentHealth
                                                                  .value
                                                                  .contains(logic
                                                                              .healthList[
                                                                          index]
                                                                      ['value'])
                                                              ? Colors.white
                                                              : AppColors
                                                                  .primaryText)),
                                                )),
                                          ));
                                    }),
                              ),
                            ],
                          ))
                    ])),
              ),
            ),
            Obx(() => Visibility(
                visible: (state.currentStep.value > 1),
                child: fixBottomContainer(
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleButton('上一步', () {
                        state.currentStep.value -= 1;
                      },
                          bgColor: const Color.fromRGBO(217, 217, 217, 1),
                          width: 112,
                          height: 46,
                          isCircle: true,
                          fontSize: 18),
                      state.currentStep.value == 7
                          ? titleButton('推荐食谱', () {
                              if (logic.isCanNext(true)) {
                                logic.recommendedRecipes();
                              }
                            },
                              bgColor: state.recentHealth.value.isEmpty
                                  ? const Color.fromRGBO(194, 229, 134, 1)
                                  : AppColors.tint,
                              width: 120,
                              height: 46,
                              isCircle: true,
                              fontSize: 18)
                          : titleButton('下一步', () {
                              if (logic.isCanNext(true)) {
                                state.currentStep.value += 1;
                              }
                            },
                              bgColor: !logic.isCanNext(false)
                                  ? const Color.fromRGBO(194, 229, 134, 1)
                                  : AppColors.tint,
                              width: 112,
                              height: 46,
                              isCircle: true,
                              fontSize: 18)
                    ],
                  ),
                )))
          ]),
        ));
  }
}
