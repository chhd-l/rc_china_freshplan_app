import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/common/router/app_router.dart';
import 'package:rc_china_freshplan_app/common/values/colors.dart';
import 'package:rc_china_freshplan_app/common/widgets/factor.dart';
import 'util.dart';
import 'tabs.dart';
import 'pet.dart';
import 'package:rc_china_freshplan_app/data/pet.dart';
import 'package:rc_china_freshplan_app/common/util/pet-util.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rc_china_freshplan_app/global.dart';
import 'package:rc_china_freshplan_app/pages/createPet/common-widget-view.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class PetDetailPage extends StatelessWidget {
  PetDetailPage({super.key});

  final TabsController c = Get.put(TabsController());
  final PetController petCtl = Get.put(PetController());
  final global = Get.put(GlobalConfigService());

  @override
  Widget build(BuildContext context) {
    var args = Get.arguments;
    var pet = PetUtil.getPet(args.toString());
    print(3333);
    print(pet.toJson());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      c.changeTab(0);
      petCtl.initData(pet);
    });

    void _handlePressSave() async {
      var updateFlag = await PetUtil.updatePet(Pet(
        id: pet.id,
        name: petCtl.name.value,
        image: petCtl.image.value,
        type: petCtl.type.value,
        gender: petCtl.gender.value,
        isSterilized: false,
        birthday: petCtl.birthday.value,
        breedCode: petCtl.breedCode.value,
        breedName: petCtl.breedName.value,
        targetWeight: petCtl.targetWeight.value,
        recentWeight: petCtl.recentWeight.value,
        recentHealth: List<String>.from(
            petCtl.recentHealth.value.map((e) => e.toString())),
        recentPosture: petCtl.recentPosture.value,
      ));
      if (updateFlag) {
        Get.toNamed(AppRoutes.petList);
      }
    }

    void _handleUploadImage() async {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
          imageQuality: 80, maxWidth: 540, source: ImageSource.gallery);
      if (pickedFile != null) {
        petCtl.uploadPetImage(pickedFile);
      }
    }

    void _handleDelete() {
      if (pet.subscriptionNo != null && pet.subscriptionNo!.isNotEmpty) {
        EasyLoading.showToast('定制计划中，暂无法删除');
      } else {
        showCupertinoDialog(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                title: const Text(''),
                content: Column(
                  children: [
                    Image.asset('assets/images/dialog-tip-icon.png'),
                    const SizedBox(height: 24),
                    Text('您确定要删除这个宠物吗？',
                        style: textSyle700(color: AppColors.text333))
                  ],
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        titleButton('确定', () async {
                          Get.back();
                          var deleteFlag = await PetUtil.removePet(pet);
                          if (deleteFlag) {
                            Get.toNamed(AppRoutes.petList);
                          }
                        },
                            width: 96,
                            height: 30,
                            isCircle: true,
                            bgColor: const Color.fromRGBO(200, 227, 153, 1),
                            fontSize: 12),
                        titleButton('我在想想', () {
                          Get.back();
                        },
                            width: 112,
                            height: 30,
                            isCircle: true,
                            fontSize: 12),
                      ],
                    ),
                  )
                ],
                insetAnimationDuration: const Duration(seconds: 2),
              );
            });
      }
    }

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
                          _handleUploadImage();
                        }, petCtl.image.value)),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Obx(() => Text(
                            petCtl.name.value,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          )),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Obx(() => Icon(
                            petCtl.type.value == 'MALE'
                                ? Icons.male
                                : Icons.female,
                            size: 16,
                            color: const Color.fromARGB(255, 212, 157, 40),
                          )),
                    ),
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
                      _handleDelete();
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
                              : const Color.fromARGB(255, 150, 204, 57),
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
                              : const Color.fromARGB(255, 150, 204, 57),
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
                        buildGenderItem(
                            Obx(() => Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 60, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: petCtl.gender.value == 'FEMALE'
                                        ? Colors.white
                                        : const Color.fromARGB(
                                            255, 150, 204, 57),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    '小鲜肉',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: petCtl.gender.value == 'FEMALE'
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                  ),
                                )),
                            Obx(() => Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 60, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: petCtl.gender.value == 'MALE'
                                        ? Colors.white
                                        : const Color.fromARGB(
                                            255, 150, 204, 57),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    '小公主',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: petCtl.gender.value == 'MALE'
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                  ),
                                )), (String gender) {
                          petCtl.changeGender(gender);
                        }),
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
                        buildPostureItem(
                            Obx(() => Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                    color: petCtl.recentPosture.value ==
                                            'EMACIATED'
                                        ? const Color.fromARGB(
                                            255, 150, 204, 57)
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/pet-thin.png',
                                        width: 62,
                                        height: 52,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(top: 10),
                                        child: Text(
                                          '瘦弱',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                            Obx(() => Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                    color:
                                        petCtl.recentPosture.value == 'STANDARD'
                                            ? const Color.fromARGB(
                                                255, 150, 204, 57)
                                            : Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/pet-std.png',
                                        width: 62,
                                        height: 52,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(top: 10),
                                        child: Text(
                                          '标准',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                            Obx(() => Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                    color:
                                        petCtl.recentPosture.value == 'OBESITY'
                                            ? const Color.fromARGB(
                                                255, 150, 204, 57)
                                            : Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/pet-fat.png',
                                        width: 62,
                                        height: 52,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(top: 10),
                                        child: Text(
                                          '超重',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )), (String posture) {
                          petCtl.changeRencentPosture(posture);
                        }),
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
        mainAxisAlignment:
            pet.subscriptionNo != null && pet.subscriptionNo!.isEmpty
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.center,
        children: [
          titleButton('保存编辑', () {
            _handlePressSave();
          },
              height: 46,
              isCircle: true,
              width: pet.subscriptionNo != null && pet.subscriptionNo!.isEmpty
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
              visible:
                  pet.subscriptionNo != null && pet.subscriptionNo!.isEmpty,
              child: titleButton('开始定制', () {
                Get.put(GlobalConfigService()).checkoutPet.value = pet;
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
