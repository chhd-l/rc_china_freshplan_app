import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/common/values/colors.dart';
import 'package:rc_china_freshplan_app/common/widgets/factor.dart';
import 'package:rc_china_freshplan_app/pages/account/common_view.dart';
import 'package:rc_china_freshplan_app/pages/createPet/choosePet/state.dart';

import 'choose_pet_view.dart';
import 'logic.dart';

class ChoosePetPage extends StatelessWidget {
  ChoosePetPage({super.key});

  final ChoosePetLogic logic = Get.put(ChoosePetLogic());
  final ChoosePetState state = Get.find<ChoosePetLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: commonAppBar('宠物'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("选择您的宠物",
              style: textSyle700(fontSize: 18, color: AppColors.text333)),
          const SizedBox(height: 22),
          Obx(() => petSection(state.petList.value.isEmpty
              ? buildEmpltyPetListRegion()
              : state.petList.value.length < 4
                  ? SizedBox(
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                              child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.petList.value.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  logic.selectPet(state.petList.value[index]);
                                },
                                child: Obx(() => petItem(
                                    state.petList.value[index],
                                    state.currentPet.value)),
                              );
                            },
                          )),
                          addPetIconView()
                        ],
                      ),
                    )
                  : SizedBox(
                      height: 120,
                      child: Swiper(
                          pagination: const SwiperPagination(
                              alignment: Alignment.bottomCenter,
                              margin: EdgeInsets.only(bottom: 0),
                              builder: RectSwiperPaginationBuilder(
                                  activeColor: AppColors.tint,
                                  color: Color.fromARGB(255, 219, 219, 219),
                                  space: 0.0,
                                  size: Size(10.0, 5.0),
                                  activeSize: Size(10.0, 5.0))),
                          itemCount: state.petList.value.length % 4 >= 0
                              ? (state.petList.value.length ~/ 4) + 1
                              : state.petList.value.length ~/ 4,
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                index * 4 <= state.petList.value.length - 1
                                    ? GestureDetector(
                                        onTap: () {
                                          logic.selectPet(
                                              state.petList.value[index * 4]);
                                        },
                                        child: Obx(() => petItem(
                                            state.petList.value[index * 4],
                                            state.currentPet.value)))
                                    : Container(),
                                index * 4 + 1 <= state.petList.value.length - 1
                                    ? GestureDetector(
                                        onTap: () {
                                          logic.selectPet(state
                                              .petList.value[index * 4 + 1]);
                                        },
                                        child: Obx(() => petItem(
                                            state.petList.value[index * 4 + 1],
                                            state.currentPet.value)))
                                    : Container(),
                                index * 4 + 2 <= state.petList.value.length - 1
                                    ? GestureDetector(
                                        onTap: () {
                                          logic.selectPet(state
                                              .petList.value[index * 4 + 2]);
                                        },
                                        child: Obx(() => petItem(
                                            state.petList.value[index * 4 + 2],
                                            state.currentPet.value)))
                                    : Container(),
                                index * 4 + 3 <= state.petList.value.length - 1
                                    ? GestureDetector(
                                        onTap: () {
                                          logic.selectPet(state
                                              .petList.value[index * 4 + 3]);
                                        },
                                        child: Obx(() => petItem(
                                            state.petList.value[index * 4 + 3],
                                            state.currentPet.value)))
                                    : Container(),
                                index ==
                                        (state.petList.value.length % 4 >= 0
                                                ? (state.petList.value.length ~/
                                                        4) +
                                                    1
                                                : state.petList.value.length ~/
                                                    4) -
                                            1
                                    ? addPetIconView()
                                    : Container()
                              ],
                            );
                          })))),
          const SizedBox(height: 30),
          titleButton('推荐食谱', () {
            logic.recommendedRecipes();
          }, isCircle: true, height: 46, width: 114),
          Image.asset('assets/images/pet-bg.png'),
        ]),
      ),
    );
  }
}
