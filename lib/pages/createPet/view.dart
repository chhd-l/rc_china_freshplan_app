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
                      child: ClipOval(
                          child: SizedBox(
                        height: 64,
                        width: 64,
                        child: Obx(() => CachedNetworkImage(
                              imageUrl: state.avatar.value != ''
                                  ? state.avatar.value
                                  : 'assets/images/pet-gray.png',
                              placeholder: (context, url) => Image.asset(
                                'assets/images/pet-gray.png',
                                fit: BoxFit.cover,
                              ),
                              errorWidget: (context, url, error) => Image.asset(
                                'assets/images/pet-gray.png',
                                fit: BoxFit.cover,
                              ),
                              fit: BoxFit.cover,
                            )),
                      )),
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

Widget headInfo(String imagePath, VoidCallback action) {
  return Stack(
    children: [
      SizedBox(width: 69.w, height: 64.w),
      Positioned(
        left: 8.w,
        child: Image.asset('assets/images/pet_icon_bg.png'),
      ),
      Positioned(
        right: 5.w,
        child: GestureDetector(
          onTap: action,
          child: ClipOval(
            child: SizedBox(
                height: 64, width: 64, child: headInfoImage(imagePath)),
          ),
        ),
      )
    ],
  );
}

Widget headInfoImage(String imagePath) {
  if (imagePath.isEmpty) return Image.asset('assets/images/pet-gray.png');
  return CachedNetworkImage(
      imageUrl: imagePath,
      placeholder: (context, url) => Image.asset(
            'assets/images/pet-gray.png',
            fit: BoxFit.cover,
          ),
      errorWidget: (context, url, error) => Image.asset(
            'assets/images/pet-gray.png',
            fit: BoxFit.cover,
          ),
      fit: BoxFit.cover);
}
