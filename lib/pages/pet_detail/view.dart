import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/common/router/app_router.dart';
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
                title: const Text('提示'),
                content: const Text('确定要删除这个宠物吗？'),
                actions: [
                  CupertinoDialogAction(
                    child: const Text('确定'),
                    onPressed: () async {
                      Get.back();
                      var deleteFlag = await PetUtil.removePet(pet);
                      if (deleteFlag) {
                        Get.toNamed(AppRoutes.petList);
                      }
                    },
                  ),
                  CupertinoDialogAction(
                    child: const Text('取消'),
                    onPressed: () {
                      Get.back();
                    },
                  ),
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
                        '性别是',
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
                        '品种是',
                        buildBreedItem(
                            Obx(() => Text(
                                  petCtl.breedName.value,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                )),
                            petCtl.type.value == 'CAT'
                                ? global.catBreedList
                                : global.dogBreedList,
                            (String name, String code) {
                          petCtl.changeBreed(name, code);
                        }),
                        ''),
                  ],
                ),
              )),
          Obx(() => Container(
                padding: const EdgeInsets.only(top: 5, bottom: 20),
                height: c.tab.value == 0 ? 0 : null,
                child: Column(
                  children: [
                    buildPetItem(
                        '近期体重',
                        buildInputNumberItem(petCtl.recentWeightController,
                            inputType: const TextInputType.numberWithOptions(
                                decimal: true),
                            handleChange: (value) {}),
                        '(kg)'),
                    buildPetItem(
                        '近期状态',
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
                        '成年目标体重',
                        buildInputNumberItem(petCtl.targetWeightController,
                            inputType: const TextInputType.numberWithOptions(
                                decimal: true),
                            handleChange: (value) {}),
                        '(kg)'),
                    buildPetItem(
                        '近期健康状况',
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
        children: [
          Expanded(
              child: MaterialButton(
            color: const Color.fromARGB(255, 150, 204, 57),
            textColor: Colors.white,
            onPressed: () {
              _handlePressSave();
            },
            elevation: 0,
            height: 44,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(22)),
            ),
            child: const Text('保存编辑'),
          )),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('档案详情'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back_ios,
          ),
          onTap: () {
            Get.toNamed(AppRoutes.petList);
          },
        ),
      ),
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
