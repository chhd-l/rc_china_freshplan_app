import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rc_china_freshplan_app/common/values/colors.dart';
import 'package:rc_china_freshplan_app/common/widgets/factor.dart';
import 'package:rc_china_freshplan_app/common/widgets/textFields.dart';
import 'package:rc_china_freshplan_app/common/router/app_router.dart';

import 'package:intl/intl.dart';

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
                // The Bottom margin is provided to align the popup above the system navigation bar.
                margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                // Provide a background color for the popup.
                color: CupertinoColors.systemBackground.resolveFrom(context),
                // Use a SafeArea widget to avoid system overlaps.
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
                  GestureDetector(
                    onTap: () {
                      logic.tapHeadIcon();
                    },
                    child: Container(
                      width: 89,
                      height: 89,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/select-pet-avatar.png'))),
                      child: Image.asset('assets/images/pet-gray.png'),
                    ),
                  ),
                  const SizedBox(height: 50),
                  commonTitle('您的爱宠是', description: '爱宠的健康之旅，从这里开始。'),
                  const SizedBox(height: 52),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Obx(() =>
                          petTypeBox(state.type.value == 'cat', 'cat', () {
                            state.type.value = 'cat';
                          })),
                      Obx(() =>
                          petTypeBox(state.type.value == 'dog', 'dog', () {
                            state.type.value = 'dog';
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
                            genderBox(state.gender.value == 'male', '小鲜肉', () {
                              state.gender.value = 'male';
                            })),
                        Obx(() => genderBox(
                                state.gender.value == 'female', '小公主', () {
                              state.gender.value = 'female';
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
                              // This is called when selected item is changed.
                              onSelectedItemChanged: (int selectedItem) {
                                state.breedName.value = '拉布拉多犬';
                              },
                              children: List<Widget>.generate(2, (int index) {
                                return const Center(
                                  child: Text('拉布拉多犬'),
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
            Container(
              decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                        color: AppColors.tabCellSeparator, width: 1.0),
                  ),
                  color: Colors.white),
              padding: EdgeInsets.fromLTRB(24.w, 19.h, 24.w, 19.h),
              child: Obx(() => titleButton('下一步', () {
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

Widget verticalOptions(List titles, Function callBack) {
  final List<Widget> widgets = titles
      .asMap()
      .entries
      .map((e) => Container(
            padding: EdgeInsets.only(bottom: 10.h),
            child: titleButton(e.value, () {
              callBack(e.value, e.key);
            }),
          ))
      .toList();

  return _bottomOption(
      Column(children: widgets), EdgeInsets.fromLTRB(24.w, 22.h, 24.w, 0));
}

Widget _bottomOption(Widget widget, EdgeInsets padding) {
  return Container(
    decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.tabCellSeparator, width: 1.0),
        ),
        color: Colors.white),
    padding: padding,
    child: SafeArea(
      child: widget,
    ),
  );
}
