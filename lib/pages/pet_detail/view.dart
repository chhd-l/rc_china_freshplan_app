import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/common/router/app_router.dart';
import 'util.dart';
import 'tabs.dart';
import 'pet.dart';

class PetDetailPage extends StatelessWidget {
  const PetDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TabsController c = Get.put(TabsController());
    final PetController petCtl = Get.put(PetController());

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
                    ClipOval(
                      child: Image.network(
                        'https://dtcdata.oss-cn-shanghai.aliyuncs.com/asset/image/cat-default.png',
                        width: 58,
                        height: 58,
                        fit: BoxFit.cover,
                      ),
                    ),
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
                      child: const Icon(
                        Icons.female,
                        size: 16,
                        color: Color.fromARGB(255, 212, 157, 40),
                      ),
                    ),
                  ],
                )),
                const Icon(
                  Icons.delete_outline,
                  size: 24,
                  color: Colors.black,
                ),
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
                        '宠物昵称', buildInputItem(petCtl.nameController), ''),
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
                    buildPetItem('品种是', buildBreedItem(), ''),
                  ],
                ),
              )),
          Obx(() => Container(
                padding: const EdgeInsets.only(top: 5, bottom: 20),
                height: c.tab.value == 0 ? 0 : null,
                child: Column(
                  children: [
                    buildPetItem(
                        '近期体重', buildInputItem(petCtl.nameController), '(kg)'),
                    buildPetItem('近期状态', buildPostureItem(), ''),
                    buildPetItem('成年目标体重',
                        buildInputItem(petCtl.nameController), '(kg)'),
                    buildPetItem('近期健康状况', buildHealthItem(), '(可多选)'),
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
            onPressed: () {},
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
