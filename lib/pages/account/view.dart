import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/common/router/app_router.dart';
import 'package:rc_china_freshplan_app/common/util/storage.dart';
import 'package:rc_china_freshplan_app/data/consumer.dart';
import 'package:rc_china_freshplan_app/common/util/pet-util.dart';
import 'package:rc_china_freshplan_app/common/util/address-util.dart';
import 'package:rc_china_freshplan_app/data/pet.dart';
import 'package:rc_china_freshplan_app/pages/pet_detail/pet.dart';
import 'controller.dart';

class AccountPage extends GetView<AccountController> {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Consumer? consumer = StorageUtil().getJSON("loginUser") != null
        ? Consumer.fromJson(StorageUtil().getJSON("loginUser"))
        : null;
    if (consumer != null) {
      controller.getPetList();
    }

    Widget loginSection = Container(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Row(children: [
        ClipOval(
          child: consumer == null
              ? Image.asset(
                  'assets/images/unlogin.png',
                  width: 55,
                  height: 55,
                  fit: BoxFit.cover,
                )
              : CachedNetworkImage(
                  imageUrl:
                      consumer.avatarUrl != null && consumer.avatarUrl != ''
                          ? consumer.avatarUrl.toString()
                          : 'assets/images/unlogin.png',
                  width: 55,
                  height: 55,
                ),
        ),
        Expanded(
            child: Container(
          margin: const EdgeInsets.only(left: 10),
          child: consumer == null
              ? GestureDetector(
                  child: const Text(
                    '点击登录',
                    style: TextStyle(
                      fontSize: 22,
                      color: Color.fromARGB(255, 51, 51, 51),
                    ),
                  ),
                  onTap: () {
                    Get.toNamed(AppRoutes.login);
                  },
                )
              : Text(
                  consumer.nickName ?? '',
                  style: const TextStyle(
                    fontSize: 22,
                    color: Color.fromARGB(255, 51, 51, 51),
                  ),
                ),
        )),
        GestureDetector(
          child: Text(
            consumer != null ? '退出' : '',
            style: const TextStyle(
              fontSize: 14,
              color: Color.fromARGB(255, 153, 153, 153),
            ),
          ),
          onTap: () {
            StorageUtil().remove('loginUser');
            StorageUtil().remove('consumerAccount');
            StorageUtil().remove('accessToken');
            PetUtil.logout();
            AddRessUtil.logout();
            Get.offAllNamed(AppRoutes.login);
          },
        ),
      ]),
    );

    Column buildOrderItem(String img, String label) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            img,
            width: 27,
            height: 27,
            fit: BoxFit.fitWidth,
          ),
          Container(
            margin: const EdgeInsets.only(top: 5),
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            ),
          )
        ],
      );
    }

    Widget orderSection = Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Column(
        children: [
          GestureDetector(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Image.asset(
                  'assets/images/order-icon.png',
                  width: 20,
                  height: 20,
                  fit: BoxFit.fitWidth,
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: const Text(
                      '我的订单',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 5),
                  child: const Text('全部订单',
                      style: TextStyle(
                        color: Color.fromARGB(255, 153, 153, 153),
                        fontSize: 12,
                      )),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Color.fromARGB(255, 153, 153, 153),
                  size: 12,
                )
              ]),
            ),
            onTap: () {
              Get.toNamed(AppRoutes.orderList);
            },
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: buildOrderItem('assets/images/unpaid-icon.png', '待付款'),
                  onTap: () {
                    Get.toNamed(AppRoutes.orderList, arguments: 'UNPAID');
                  },
                ),
                GestureDetector(
                  child: buildOrderItem('assets/images/unship-icon.png', '待发货'),
                  onTap: () {
                    Get.toNamed(AppRoutes.orderList, arguments: 'TO_SHIP');
                  },
                ),
                GestureDetector(
                  child:
                      buildOrderItem('assets/images/shipped-icon.png', '待收货'),
                  onTap: () {
                    Get.toNamed(AppRoutes.orderList, arguments: 'SHIPPED');
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );

    Widget buildEmpltyPetListRegion() {
      return Row(
        children: [
          GestureDetector(
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(29),
                color: const Color.fromARGB(255, 249, 249, 249),
                border: Border.all(
                  color: const Color.fromARGB(255, 219, 219, 219),
                  width: 1,
                  style: BorderStyle.solid,
                ),
              ),
              child: const Icon(
                Icons.add,
                size: 30,
                color: Colors.black,
              ),
            ),
            onTap: () {
              Get.toNamed(AppRoutes.createPet);
            },
          ),
          GestureDetector(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 3),
                  child: const Text(
                    '添加爱宠',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Text(
                  '给它定制专属食物',
                  style: TextStyle(
                    color: Color.fromARGB(255, 153, 153, 153),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            onTap: () {
              Get.toNamed(AppRoutes.createPet);
            },
          ),
        ],
      );
    }

    Widget buildPetListRegion = GetBuilder<AccountController>(builder: (_) {
      if (controller.petList.isEmpty) {
        return buildEmpltyPetListRegion();
      }
      return SizedBox(
        height: 80,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.petList.length,
          itemBuilder: (context, index) {
            var pet = controller.petList[index];
            return Container(
              margin: const EdgeInsets.only(right: 30),
              height: 80,
              child: Column(
                children: [
                  ClipOval(
                    child: Image.network(
                      (pet.image == null || pet.image == '')
                          ? (pet.type == 'CAT'
                              ? 'https://dtcdata.oss-cn-shanghai.aliyuncs.com/asset/image/cat-default.png'
                              : 'https://dtcdata.oss-cn-shanghai.aliyuncs.com/asset/image/dog-default.png')
                          : pet.image ?? '',
                      width: 58,
                      height: 58,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Expanded(
                      child: Text(
                    pet.name ?? '',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color.fromARGB(255, 57, 57, 57),
                    ),
                  )),
                ],
              ),
            );
          },
        ),
      );
    });

    Widget petSection = Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Column(
        children: [
          GestureDetector(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Image.asset(
                  'assets/images/petfoot-icon.png',
                  width: 20,
                  height: 20,
                  fit: BoxFit.fitWidth,
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: const Text(
                      '我的宠物',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 5),
                  child: const Text('宠物管理',
                      style: TextStyle(
                        color: Color.fromARGB(255, 153, 153, 153),
                        fontSize: 12,
                      )),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Color.fromARGB(255, 153, 153, 153),
                  size: 12,
                )
              ]),
            ),
            onTap: () {
              Get.toNamed(AppRoutes.petList);
            },
          ),
          Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: buildPetListRegion)
        ],
      ),
    );

    Widget addressSection = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: GestureDetector(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/location-icon.png',
              width: 20,
              height: 20,
              fit: BoxFit.fitWidth,
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                child: const Text(
                  '收货地址',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Color.fromARGB(255, 153, 153, 153),
              size: 12,
            ),
          ],
        ),
        onTap: () {
          Get.toNamed(AppRoutes.addressManage);
        },
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('我的'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 195, 236, 123),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 195, 236, 123),
                Color.fromARGB(0, 195, 236, 123),
              ]),
        ),
        child: Column(children: [
          loginSection,
          orderSection,
          petSection,
          addressSection,
        ]),
      )),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/freshplan.png',
              width: 22,
              height: 22,
            ),
            activeIcon: Image.asset(
              'assets/images/freshplan-selected.png',
              width: 22,
              height: 22,
            ),
            label: '智能推荐',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/home.png',
              width: 22,
              height: 22,
            ),
            activeIcon: Image.asset(
              'assets/images/home-selected.png',
              width: 22,
              height: 22,
            ),
            label: '我的',
          ),
        ],
        unselectedItemColor: const Color.fromARGB(255, 153, 153, 153),
        selectedItemColor: const Color.fromARGB(255, 150, 204, 57),
        currentIndex: 1,
        onTap: (idx) {
          if (idx == 0) {
            Get.toNamed(AppRoutes.index);
          } else {
            Get.toNamed(AppRoutes.account);
          }
        },
      ),
    );
  }
}
