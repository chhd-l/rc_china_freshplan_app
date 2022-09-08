import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rc_china_freshplan_app/common/values/colors.dart';
import 'package:rc_china_freshplan_app/common/widgets/factor.dart';
import 'package:rc_china_freshplan_app/common/widgets/textFields.dart';
import 'package:rc_china_freshplan_app/common/router/app_router.dart';

import 'common-widget-view.dart';

class CreatePetPage extends StatelessWidget {
  const CreatePetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: commonAppBar('创建宠物档案'),
        body: SafeArea(
          child: Column(children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                    right: 16.w, left: 16.w, top: 40.w, bottom: 16.h),
                child: Column(children: [
                  Container(
                    width: 89,
                    height: 89,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/images/select-pet-avatar.png'))),
                    child: Image.asset('assets/images/pet-gray.png'),
                  ),
                  const SizedBox(height: 50),
                  commonTitle('您的爱宠是', description: '爱宠的健康之旅，从这里开始。'),
                  const SizedBox(height: 52),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Image.asset('assets/images/cat.png'),
                          const SizedBox(height: 20),
                          Text(
                            '猫猫',
                            style: textSyle700(
                                fontSize: 16,
                                color: const Color.fromRGBO(153, 153, 153, 1)),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Image.asset('assets/images/dog.png'),
                          const SizedBox(height: 20),
                          Text(
                            '狗狗',
                            style: textSyle700(
                                fontSize: 16,
                                color: const Color.fromRGBO(153, 153, 153, 1)),
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 46),
                  commonTitle('您爱宠的昵称是'),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 32),
                    child: textFiled(),
                  ),
                  commonTitle('您爱宠的性别'),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 160,
                          height: 50,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(246, 246, 246, 1),
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              )),
                          child: Text('小鲜肉', style: textSyle700(fontSize: 15)),
                        ),
                        Container(
                          width: 160,
                          height: 50,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(246, 246, 246, 1),
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              )),
                          child: Text('小公主', style: textSyle700(fontSize: 15)),
                        )
                      ],
                    ),
                  ),
                  commonTitle('球球的品种是'),
                  Padding(
                    padding: const EdgeInsets.only(top: 26, bottom: 32),
                    child: selectBox(),
                  ),
                  commonTitle('球球多大了', subTitle: '（选择出生日期）'),
                  Padding(
                    padding: const EdgeInsets.only(top: 26, bottom: 32),
                    child: selectBox(),
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
              child: titleButton('下一步', () {
                Get.offAllNamed(AppRoutes.createPetNext);
              }),
            )
          ]),
        ));
  }
}

