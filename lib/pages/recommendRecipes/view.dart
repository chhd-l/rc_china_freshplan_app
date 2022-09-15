import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/common/widgets/factor.dart';
import 'package:rc_china_freshplan_app/pages/createPet/common-widget-view.dart';

import 'logic.dart';
import 'recommend_recipes_common_view.dart';

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
                padding: const EdgeInsets.all(16),
                child: Column(children: [
                  Text(
                    '${logic.global.petName.value}的专属健康食谱',
                    style: textSyle900(fontSize: 23),
                  ),
                  Obx(() => richText(
                      '专家根据您的宠物信息推荐', logic.recommendProductsName.value, '套餐')),
                  richText('最多选择', '两个', '套餐'),
                  const SizedBox(height: 24),
                  Obx(() => ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: logic.global.recipesList.length,
                      itemBuilder: (context, index) {
                        final item = logic.global.recipesList[index];
                        final value = logic.global.recipesList[index]
                            ["variants"][0]["id"];
                        return GestureDetector(
                            onTap: () {
                              logic.selectRecipesItem(value);
                            },
                            child: Obx(
                              () => recipesItem(
                                  logic.selectedProduct.contains(value),
                                  item["variants"][0]["defaultImage"],
                                  item['name'],
                                  item['description']),
                            ));
                      }))
                ]),
              ),
            ),
            fixBottomContainer(titleButton('立即购买', () {
              logic.gotoPurchase();
            })),
          ]),
        ));
  }
}
