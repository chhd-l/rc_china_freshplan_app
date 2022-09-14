import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rc_china_freshplan_app/common/values/colors.dart';
import 'package:rc_china_freshplan_app/common/widgets/factor.dart';
import 'package:rc_china_freshplan_app/common/widgets/textFields.dart';
import 'package:rc_china_freshplan_app/common/router/app_router.dart';

import 'package:intl/intl.dart';
import 'package:rc_china_freshplan_app/global.dart';

import 'common-widget-view.dart';
import 'logic.dart';
import 'state.dart';

class CreatePetPage extends StatelessWidget {
  CreatePetPage({super.key});

  final CreatePetLogic logic = Get.put(CreatePetLogic());
  final CreatePetState state = Get.find<CreatePetLogic>().state;

  @override
  Widget build(BuildContext context) {
    void _showDialog(Widget child) {
      showCupertinoModalPopup<void>(
          context: context,
          builder: (BuildContext context) => Container(
                height: 216,
                padding: const EdgeInsets.only(top: 6.0),
                margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                color: CupertinoColors.systemBackground.resolveFrom(context),
                child: SafeArea(
                  top: false,
                  child: child,
                ),
              ));
    }

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
                  Obx(() => petAvatarPick(() {
                        logic.tapHeadIcon();
                      }, state.avatar.value)),
                  const SizedBox(height: 50),
                  commonTitle('您的爱宠是', description: '爱宠的健康之旅，从这里开始。'),
                  const SizedBox(height: 52),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Obx(() =>
                          petTypeBox(state.type.value == 'CAT', 'cat', () {
                            logic.changeType('CAT');
                          })),
                      Obx(() =>
                          petTypeBox(state.type.value == 'DOG', 'dog', () {
                            logic.changeType('DOG');
                          })),
                    ],
                  ),
                  const SizedBox(height: 46),
                  commonTitle('您爱宠的昵称是'),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 32),
                    child: textFiled(
                      controller: logic.petNameController,
                    ),
                  ),
                  commonTitle('您爱宠的性别'),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Obx(() =>
                            genderBox(state.gender.value == 'MALE', '小鲜肉', () {
                              state.gender.value = 'MALE';
                            })),
                        Obx(() => genderBox(
                                state.gender.value == 'FEMALE', '小公主', () {
                              state.gender.value = 'FEMALE';
                            })),
                      ],
                    ),
                  ),
                  Obx(() => commonTitle('${state.name.value}的品种是')),
                  Padding(
                    padding: const EdgeInsets.only(top: 26, bottom: 32),
                    child: Obx(() => selectBox(
                        value: state.breedName.value,
                        onPressed: () {
                          _showDialog(
                            CupertinoPicker(
                              magnification: 1.22,
                              squeeze: 1.2,
                              useMagnifier: true,
                              itemExtent: 32.0,
                              onSelectedItemChanged: (int selectedItem) {
                                state.breedName.value =
                                    state.breedList[selectedItem]['name'];
                                state.breedCode.value =
                                state.breedList[selectedItem]['code'];
                              },
                              children: List<Widget>.generate(
                                  state.breedList.length, (int index) {
                                return Center(
                                  child: Text(state.breedList[index]["name"]),
                                );
                              }),
                            ),
                          );
                        })),
                  ),
                  Obx(() => commonTitle('${state.name.value}多大了',
                      subTitle: '（选择出生日期）')),
                  Padding(
                    padding: const EdgeInsets.only(top: 26, bottom: 32),
                    child: Obx(() => selectBox(
                        value: state.birthday.value,
                        onPressed: () {
                          Get.bottomSheet(Container(
                            height: 200,
                            color: Colors.white,
                            alignment: Alignment.center,
                            child: CupertinoDatePicker(
                              onDateTimeChanged: (dateTime) {
                                state.birthday.value = DateFormat("yyyy-MM-dd")
                                    .format(dateTime)
                                    .toString();
                              },
                              initialDateTime: DateTime.now(),
                              minuteInterval: 1,
                              mode: CupertinoDatePickerMode.date,
                            ),
                          ));
                        })),
                  ),
                ]),
              ),
            ),
            fixBottomContainer(
              Obx(() => titleButton('下一步', () {
                    if (logic.isCanNext()) {
                      Get.toNamed(AppRoutes.createPetNext);
                    }
                  },
                      bgColor: !logic.isCanNext()
                          ? const Color.fromRGBO(194, 229, 134, 1)
                          : AppColors.tint)),
            )
          ]),
        ));
  }
}

