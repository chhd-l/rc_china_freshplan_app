import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rc_china_freshplan_app/common/values/colors.dart';
import 'package:rc_china_freshplan_app/common/widgets/factor.dart';
import 'package:rc_china_freshplan_app/common/widgets/textFields.dart';
import 'package:rc_china_freshplan_app/common/router/app_router.dart';
import 'package:rc_china_freshplan_app/pages/pet/createPet/common-widget-view.dart';

import 'logic.dart';

class RecommendRecipesPage extends StatelessWidget {
  RecommendRecipesPage({super.key});

  final RecommendRecipesLogic logic = Get.put(RecommendRecipesLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: commonAppBar('推荐食谱'),
        body: SafeArea(
          child: Column(children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                    right: 16.w, left: 16.w, top: 40.w, bottom: 16.h),
                child: Column(children: [
                  Text(
                    '球球的专属健康食谱',
                    style: textSyle900(fontSize: 23),
                  ),
                  RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                        style: textSyle700(
                            fontSize: 16,
                            color: const Color.fromRGBO(51, 51, 51, 1)),
                        children: const [
                          TextSpan(text: '专家根据您的宠物信息推荐牛肉泥套餐'),
                          TextSpan(
                            text: '牛肉泥',
                            style: TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(150, 204, 57, 1)),
                          ),
                          TextSpan(text: '套餐'),
                        ]),
                  ),
                  RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                        style: textSyle700(
                            fontSize: 16,
                            color: const Color.fromRGBO(51, 51, 51, 1)),
                        children: const [
                          TextSpan(text: '最多选择'),
                          TextSpan(
                            text: '两个',
                            style: TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(150, 204, 57, 1)),
                          ),
                          TextSpan(text: '套餐'),
                        ]),
                  ),
                  const SizedBox(height: 24),
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: logic.recipesList.length,
                      itemBuilder: (context, index) {
                        return recipesItem(
                            logic.recipesList[index]['assets'],
                            logic.recipesList[index]['name'],
                            logic.recipesList[index]['description']);
                      })
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
              child: titleButton('立即购买', () {
                Get.offAllNamed(AppRoutes.checkout);
              }),
            )
          ]),
        ));
  }
}

Widget recipesItem(String assets, String title, String description) {
  return Container(
    margin: const EdgeInsets.only(bottom: 24),
    decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 0),
              color: Color.fromRGBO(85, 134, 1, 0.1),
              blurRadius: 4.0,
              blurStyle: BlurStyle.solid,
              spreadRadius: 0.0)
        ]),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(assets),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style:
                  textSyle700(fontSize: 18, color: Color.fromRGBO(7, 7, 7, 1)),
            ),
            Text(
              description,
              style: textSyle700(
                  fontSize: 13, color: Color.fromRGBO(153, 153, 153, 1)),
            ),
          ],
        ),
        Image.asset('assets/images/checkbox.png')
      ],
    ),
  );
}
