import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/common/router/app_router.dart';
import 'package:rc_china_freshplan_app/common/util/storage.dart';

class PetListPage extends StatelessWidget {
  const PetListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('宠物列表'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back_ios,
          ),
          onTap: () {
            Get.toNamed(AppRoutes.account);
          },
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 249, 249, 249),
      body: Container(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            Expanded(
                child: ListView(
              children: [
                GestureDetector(
                  child: Container(
                    margin: const EdgeInsets.all(15),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        ClipOval(
                          child: Image.network(
                            'https://dtcdata.oss-cn-shanghai.aliyuncs.com/asset/image/cat-default.png',
                            width: 58,
                            height: 58,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(right: 5),
                                      child: const Text(
                                        '球球',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const Icon(
                                      Icons.female,
                                      size: 12,
                                      color: Color.fromARGB(255, 212, 157, 40),
                                    ),
                                  ],
                                ),
                                const Text(
                                  '英国短毛猫 1岁1个月',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color:
                                          Color.fromARGB(255, 153, 153, 153)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 12,
                          color: Color.fromARGB(255, 157, 157, 157),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Get.toNamed(AppRoutes.petDetail);
                  },
                ),
              ],
            )),
            Container(
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
                      Get.toNamed(AppRoutes.createPet);
                    },
                    elevation: 0,
                    height: 44,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(22)),
                    ),
                    child: const Text('添加宠物'),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
