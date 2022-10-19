import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/common/router/app_router.dart';
import 'package:rc_china_freshplan_app/common/util/pet-util.dart';
import 'package:rc_china_freshplan_app/common/values/colors.dart';
import 'package:rc_china_freshplan_app/common/widgets/factor.dart';
import 'util.dart';
import 'tabs.dart';
import 'pet.dart';
import 'package:rc_china_freshplan_app/global.dart';
import 'package:rc_china_freshplan_app/pages/createPet/common-widget-view.dart';

class PetDetailPage extends StatelessWidget {
  PetDetailPage({super.key});

  final TabsController c = Get.put(TabsController());
  final PetController petCtl = Get.put(PetController());
  final global = Get.put(GlobalConfigService());

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      c.changeTab(0);
    });

    Widget bodySection = SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            color: Colors.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Obx(() => petAvatarPick(() {
                          PetUtil.selectImageType();
                        }, petCtl.image.value)),
                    const SizedBox(width: 10),
                    Obx(() => Text(
                          petCtl.name.value,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        )),
                    const SizedBox(width: 10),
                    Obx(() => Icon(
                          petCtl.type.value == 'MALE'
                              ? Icons.male
                              : Icons.female,
                          size: 16,
                          color: const Color.fromARGB(255, 212, 157, 40),
                        )),
                  ],
                )),
                GestureDetector(
                    child: Image.asset(
                      'assets/images/ressDelete.png',
                      width: 27,
                      height: 27,
                      fit: BoxFit.fitWidth,
                    ),
                    onTap: () {
                      petCtl.handleDelete(context);
                    }),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            color: Colors.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  child: Obx(() => Text(
                        '基本信息',
                        style: TextStyle(
                          fontSize: 18,
                          color: c.tab.value == 1
                              ? const Color.fromARGB(255, 11, 11, 11)
                              : AppColors.tint,
                        ),
                      )),
                  onTap: () {
                    c.changeTab(0);
                  },
                ),
                GestureDetector(
                  child: Obx(() => Text(
                        '体征档案',
                        style: TextStyle(
                          fontSize: 18,
                          color: c.tab.value == 0
                              ? const Color.fromARGB(255, 11, 11, 11)
                              : AppColors.tint,
                        ),
                      )),
                  onTap: () {
                    c.changeTab(1);
                  },
                ),
              ],
            ),
          ),
          Obx(() => Container(
                padding: const EdgeInsets.only(top: 5, bottom: 20),
                height: c.tab.value == 1 ? 0 : null,
                child: Column(
                  children: [
                    buildPetItem(
                        '宠物昵称',
                        buildInputItem(petCtl.nameController,
                            handleChange: (value) {}),
                        ''),
                    buildPetItem(
                        '宠物生日',
                        buildDateTimeItem(
                            context,
                            Obx(() => Text(
                                  petCtl.birthday.value,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                )), (d) {
                          petCtl.changeBirthDay(d);
                        }),
                        ''),
                    buildPetItem(
                        '${petCtl.name.value}是',
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              genderBox(petCtl.gender.value == 'MALE', '小鲜肉',
                                  () {
                                petCtl.changeGender('MALE');
                              }, bgColor: Colors.white),
                              genderBox(petCtl.gender.value == 'FEMALE', '小公主',
                                  () {
                                petCtl.changeGender('FEMALE');
                              }, bgColor: Colors.white),
                            ],
                          ),
                        ),
                        ''),
                    buildPetItem(
                        '${petCtl.name.value}的品种是',
                        Padding(
                          padding: const EdgeInsets.only(top: 26, bottom: 32),
                          child: Column(
                            children: [
                              SizedBox(
                                  height: 200,
                                  child: GridView.builder(
                                      itemCount: 9,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              crossAxisSpacing: 10,
                                              mainAxisSpacing: 10,
                                              childAspectRatio: 2.2),
                                      itemBuilder: (context, index) {
                                        final breed = petCtl.type.value == 'DOG'
                                            ? global.dogBreedList[index]
                                            : global.catBreedList[index];
                                        return GestureDetector(
                                            onTap: () {
                                              petCtl.breedName.value =
                                                  breed["name"];
                                              petCtl.breedCode.value =
                                                  breed["code"];
                                            },
                                            child: Container(
                                              width: 110,
                                              height: 20,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color:
                                                      petCtl.breedName.value ==
                                                              breed["name"]
                                                          ? AppColors.tint
                                                          : Colors.white,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(15))),
                                              child: Text(breed["name"],
                                                  style: textSyle700(
                                                      fontSize: 15,
                                                      color: petCtl.breedName
                                                                  .value ==
                                                              breed["name"]
                                                          ? Colors.white
                                                          : AppColors
                                                              .primaryText),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ));
                                      })),
                              selectBox(
                                  value: petCtl.breedName.value,
                                  onPressed: () {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    petCtl.selectBreed();
                                  },
                                  bgColor: petCtl.breedName.value == ''
                                      ? Colors.white
                                      : AppColors.tint,
                                  fontColor: petCtl.breedName.value == ''
                                      ? AppColors.primaryText
                                      : Colors.white)
                            ],
                          ),
                        ),
                        ''),
                    buildPetItem(
                        '${petCtl.name.value}的绝育状态',
                        Padding(
                          padding: const EdgeInsets.only(top: 16, bottom: 32),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              genderBox(petCtl.isSterilized == false, '未绝育',
                                  () {
                                print(111);
                                petCtl.changeIsSterilized(false);
                              }, bgColor: Colors.white),
                              genderBox(petCtl.isSterilized == true, '已绝育', () {
                                petCtl.changeIsSterilized(true);
                              }, bgColor: Colors.white),
                            ],
                          ),
                        ),
                        '')
                  ],
                ),
              )),
          Obx(() => Container(
                padding: const EdgeInsets.only(top: 5, bottom: 20),
                height: c.tab.value == 0 ? 0 : null,
                child: Column(
                  children: [
                    buildPetItem(
                        '${petCtl.name.value}近期体重',
                        selectBox(
                            value: petCtl.recentWeight.value.toString(),
                            onPressed: () {
                              petCtl.selectWeight(context, 'now');
                            },
                            bgColor: Colors.white),
                        '(kg)'),
                    buildPetItem(
                        '${petCtl.name.value}近期状态',
                        Container(
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    child: statusBox(
                                        petCtl.recentPosture.value ==
                                            'EMACIATED',
                                        'thin',
                                        '瘦弱', () {
                                  petCtl.recentPosture.value = 'EMACIATED';
                                }, bgColor: Colors.white)),
                                Expanded(
                                    child: statusBox(
                                        petCtl.recentPosture.value ==
                                            'STANDARD',
                                        'standard',
                                        '标准', () {
                                  petCtl.recentPosture.value = 'STANDARD';
                                }, bgColor: Colors.white)),
                                Expanded(
                                    child: statusBox(
                                        petCtl.recentPosture.value == 'OBESITY',
                                        'overweight',
                                        '超重', () {
                                  petCtl.recentPosture.value = 'OBESITY';
                                }, bgColor: Colors.white)),
                              ],
                            )),
                        ''),
                    buildPetItem(
                        '${petCtl.name.value}成年目标体重',
                        selectBox(
                            value: petCtl.targetWeight.value.toString(),
                            onPressed: () {
                              petCtl.selectWeight(context, 'target');
                            },
                            bgColor: Colors.white),
                        '(kg)'),
                    buildPetItem(
                        '${petCtl.name.value}近期健康状况',
                        buildHealthItem(
                            Obx(() => Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  decoration: BoxDecoration(
                                    color: petCtl.recentHealth.value
                                            .contains("PICKY_EATER")
                                        ? const Color.fromARGB(
                                            255, 150, 204, 57)
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '对食物很挑剔',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: petCtl.recentHealth.value
                                                  .contains("PICKY_EATER")
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                            Obx(() => Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  decoration: BoxDecoration(
                                    color: petCtl.recentHealth.value.contains(
                                            "FOOD_ALLERGIES_OR_STOMACH_SENSITIVITIES")
                                        ? const Color.fromARGB(
                                            255, 150, 204, 57)
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '食物过敏或胃敏感',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: petCtl.recentHealth.value.contains(
                                                  "FOOD_ALLERGIES_OR_STOMACH_SENSITIVITIES")
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                            Obx(() => Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  decoration: BoxDecoration(
                                    color: petCtl.recentHealth.value
                                            .contains("DULL_OR_FLAKY_FUR")
                                        ? const Color.fromARGB(
                                            255, 150, 204, 57)
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '无光泽或片状被毛',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: petCtl.recentHealth.value
                                                  .contains("DULL_OR_FLAKY_FUR")
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                            Obx(() => Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  decoration: BoxDecoration(
                                    color: petCtl.recentHealth.value
                                            .contains("ARTHRITIS_OR_JOINT_PAIN")
                                        ? const Color.fromARGB(
                                            255, 150, 204, 57)
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '关节炎或关节痛',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: petCtl.recentHealth.value
                                                  .contains(
                                                      "ARTHRITIS_OR_JOINT_PAIN")
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                            Obx(() => Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  decoration: BoxDecoration(
                                    color: petCtl.recentHealth.value
                                            .contains("NONE")
                                        ? const Color.fromARGB(
                                            255, 150, 204, 57)
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '以上都没有',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: petCtl.recentHealth.value
                                                  .contains("NONE")
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                )), (String health) {
                          petCtl.addRencentHealth(health);
                        }),
                        '(可多选)'),
                  ],
                ),
              )),
        ],
      ),
    );

    Widget footSection = Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: petCtl.pet.subscriptionNo != null &&
                petCtl.pet.subscriptionNo!.isEmpty
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.center,
        children: [
          titleButton('保存编辑', () {
            petCtl.handlePressSave();
          },
              height: 46,
              isCircle: true,
              width: petCtl.pet.subscriptionNo != null &&
                      petCtl.pet.subscriptionNo!.isEmpty
                  ? 155
                  : 280,
              icon: Padding(
                padding: const EdgeInsets.only(right: 10, top: 4),
                child: Image.asset(
                  'assets/images/save-edit-icon.png',
                  width: 22,
                  height: 22,
                  fit: BoxFit.cover,
                ),
              )),
          Visibility(
              visible: petCtl.pet.subscriptionNo != null &&
                  petCtl.pet.subscriptionNo!.isEmpty,
              child: titleButton('开始定制', () {
                Get.put(GlobalConfigService()).checkoutPet.value = petCtl.pet;
                Get.toNamed(AppRoutes.recommendRecipes);
              },
                  width: 155,
                  height: 46,
                  isCircle: true,
                  icon: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Image.asset(
                      'assets/images/time.png',
                      width: 22,
                      height: 22,
                      fit: BoxFit.cover,
                    ),
                  )))
        ],
      ),
    );

    return Scaffold(
      appBar: commonAppBar('档案详情'),
      backgroundColor: const Color.fromARGB(255, 249, 249, 249),
      body: Column(
        children: [
          const SizedBox(
            height: 5,
          ),
          Expanded(child: bodySection),
          footSection,
        ],
      ),
    );
  }
}
