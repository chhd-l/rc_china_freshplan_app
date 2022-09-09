import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rc_china_freshplan_app/common/values/colors.dart';
import 'package:rc_china_freshplan_app/common/widgets/factor.dart';
import 'package:rc_china_freshplan_app/common/router/app_router.dart';

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
                padding: EdgeInsets.all(16),
                child: Column(children: [
                  Text(
                    '${logic.petName}的专属健康食谱',
                    style: textSyle900(fontSize: 23),
                  ),
                  RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                        style: textSyle700(
                            fontSize: 16,
                            color: const Color.fromRGBO(51, 51, 51, 1)),
                        children: [
                          const TextSpan(text: '专家根据您的宠物信息推荐牛肉泥套餐'),
                          TextSpan(
                            text: logic.global.recipesList[logic.initIndex]
                                ['name'],
                            style: const TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(150, 204, 57, 1)),
                          ),
                          const TextSpan(text: '套餐'),
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
                      itemCount: logic.global.recipesList.length,
                      itemBuilder: (context, index) {
                        final item = logic.global.recipesList[index];
                        return GestureDetector(
                          onTap: () {
                            if (logic.selectedProduct.contains(item['value'])) {
                              logic.selectedProduct.remove(item['value']);
                            } else if (logic.selectedProduct.length < 2) {
                              logic.selectedProduct.insert(0, item['value']);
                            }
                          },
                          child: Obx(() => recipesItem(
                              logic.selectedProduct.contains(item['value']),
                              item['assets'],
                              item['name'],
                              item['description'])),
                        );
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
                logic.global.selectProduct.value = logic.selectedProduct;
                Get.toNamed(AppRoutes.checkout);
              }),
            )
          ]),
        ));
  }
}

Widget recipesItem(
    bool isSelected, String assets, String title, String description) {
  return Container(
    margin: const EdgeInsets.only(bottom: 24),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        border: Border.all(
            color: isSelected
                ? const Color.fromRGBO(150, 204, 57, 1)
                : Colors.white),
        boxShadow: const [
          BoxShadow(
              offset: Offset(0, 0),
              color: Color.fromRGBO(85, 134, 1, 0.2),
              blurRadius: 4.0,
              blurStyle: BlurStyle.solid,
              spreadRadius: 0.0)
        ]),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(assets),
        Expanded(
            child: Container(
          margin: const EdgeInsets.only(left: 8),
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: textSyle700(
                    fontSize: 18, color: const Color.fromRGBO(7, 7, 7, 1)),
              ),
              Text(
                description,
                style: textSyle700(fontSize: 13, color: AppColors.text999),
              ),
            ],
          ),
        )),
        isSelected
            ? Image.asset('assets/images/checkbox-selected.png')
            : Image.asset('assets/images/checkbox.png')
      ],
    ),
  );
}
