import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rc_china_freshplan_app/common/router/app_router.dart';
import 'package:rc_china_freshplan_app/common/values/colors.dart';
import 'package:rc_china_freshplan_app/common/widgets/factor.dart';
import 'package:rc_china_freshplan_app/common/widgets/textFields.dart';

import 'common-widget-view.dart';
import 'logic.dart';

class CreatePetNextPage extends StatelessWidget {
  CreatePetNextPage({super.key});

  final CreatePetLogic logic = Get.put(CreatePetLogic());

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
                  commonTitle('球球近期的体重', subTitle: '（kg）'),
                  Padding(
                    padding: const EdgeInsets.only(top: 26, bottom: 32),
                    child: selectBox(),
                  ),
                  commonTitle('球球近期状态'),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 32),
                    child: Row(
                      children: [
                        statusBox('assets/images/fit.png', '瘦弱'),
                        statusBox('assets/images/standrad.png', '标准'),
                        statusBox('assets/images/oversize.png', '超重'),
                      ],
                    ),
                  ),
                  commonTitle('球球近期成年目标体重', subTitle: '（kg）'),
                  Padding(
                    padding: const EdgeInsets.only(top: 26, bottom: 32),
                    child: selectBox(),
                  ),
                  commonTitle('球球近期的健康情况', subTitle: '（可多选）'),
                  Padding(
                    padding: const EdgeInsets.only(top: 26, bottom: 32),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: logic.healthList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Container(
                              height: 50,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                  color: Color.fromRGBO(246, 246, 246, 1),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  )),
                              child: Text(
                                logic.healthList[index]['name'],
                                style: textSyle700(fontSize: 15),
                              ),
                            ),
                          );
                        }),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  titleButton('上一步', () {},
                      width: 145,
                      bgColor: const Color.fromRGBO(217, 217, 217, 1)),
                  titleButton('推荐食谱', () {
                    Get.offAllNamed(AppRoutes.recommendRecipes);
                  }, width: 145)
                ],
              ),
            )
          ]),
        ));
  }
}

Widget statusBox(String iconAsset, String title) {
  return Container(
    width: 130,
    height: 112,
    alignment: Alignment.center,
    decoration: const BoxDecoration(color: Color.fromRGBO(246, 246, 246, 1)),
    child: Column(
      children: [
        const SizedBox(height: 20),
        Image.asset(iconAsset),
        const SizedBox(height: 8),
        Text(
          title,
          style: textSyle400(fontSize: 14),
        )
      ],
    ),
  );
}
