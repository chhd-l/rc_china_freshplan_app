import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/common/router/app_router.dart';
import 'package:rc_china_freshplan_app/common/util/storage.dart';
import 'package:rc_china_freshplan_app/common/values/colors.dart';
import 'package:rc_china_freshplan_app/data/consumer.dart';
import 'package:rc_china_freshplan_app/common/util/pet-util.dart';
import 'package:rc_china_freshplan_app/common/util/address-util.dart';
import '../../common/widgets/factor.dart';
import 'common-view.dart';
import 'controller.dart';

class AccountPage extends GetView<AccountController> {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Consumer? consumer = StorageUtil().getJSON("loginUser") != null
        ? Consumer.fromJson(StorageUtil().getJSON("loginUser"))
        : null;
    // if (consumer != null) {
    //   controller.getPetList();
    //   controller.getOrderStatistics();
    // }

    Widget loginSection = Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
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

    Widget orderSection = GetBuilder<AccountController>(builder: (_) {
      return Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Column(
          children: [
            GestureDetector(
              child: commonBoxTitle('assets/images/order-icon.png', '我的订单',
                  subTitle: '全部订单'),
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
                    child: buildOrderItem('assets/images/unpaid-icon.png',
                        '待付款', controller.unpaidOrderQuantity.value),
                    onTap: () {
                      Get.toNamed(AppRoutes.orderList, arguments: 'UNPAID');
                    },
                  ),
                  GestureDetector(
                    child: buildOrderItem('assets/images/unship-icon.png',
                        '待发货', controller.toShipOrderQuantity.value),
                    onTap: () {
                      Get.toNamed(AppRoutes.orderList, arguments: 'TO_SHIP');
                    },
                  ),
                  GestureDetector(
                    child: buildOrderItem('assets/images/shipped-icon.png',
                        '待收货', controller.shippedOrderQuantity.value),
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
    });

    Widget buildPetListRegion2 = GetBuilder<AccountController>(builder: (_) {
      return SizedBox(
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
                child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.petList.length,
              itemBuilder: (context, index) {
                return petItemView(controller.petList[index]);
              },
            )),
            addPetIconView()
          ],
        ),
      );
    });

    Widget buildPetListRegion = GetBuilder<AccountController>(builder: (_) {
      if (controller.petList.isEmpty) {
        return buildEmpltyPetListRegion();
      }
      if (controller.petList.length < 4) {
        return buildPetListRegion2;
      }
      final length = controller.petList.length % 4 >= 0
          ? (controller.petList.length ~/ 4) + 1
          : controller.petList.length ~/ 4;
      return SizedBox(
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
              // indicatorLayout: PageIndicatorLayout.NONE,
              itemCount: length,
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    index * 4 <= controller.petList.length - 1
                        ? petItemView(controller.petList[index * 4])
                        : Container(),
                    index * 4 + 1 <= controller.petList.length - 1
                        ? petItemView(controller.petList[index * 4 + 1])
                        : Container(),
                    index * 4 + 2 <= controller.petList.length - 1
                        ? petItemView(controller.petList[index * 4 + 2])
                        : Container(),
                    index * 4 + 3 <= controller.petList.length - 1
                        ? petItemView(controller.petList[index * 4 + 3])
                        : Container(),
                    index == length - 1 ? addPetIconView() : Container()
                  ],
                );
              }));
    });

    Widget petSection = Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Column(
        children: [
          GestureDetector(
            child: commonBoxTitle('assets/images/petfoot-icon.png', '我的宠物',
                subTitle: '宠物管理'),
            onTap: () {
              Get.toNamed(AppRoutes.petList);
            },
          ),
          Container(
              padding: const EdgeInsets.only(bottom: 20),
              child: buildPetListRegion)
        ],
      ),
    );

    Widget addressSection = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: GestureDetector(
        child: commonBoxTitle(
          'assets/images/location-icon.png',
          '收货地址',
        ),
        onTap: () {
          Get.toNamed(AppRoutes.addressManage);
        },
      ),
    );

    Widget invoiceSection = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: GestureDetector(
        child: commonBoxTitle(
          'assets/images/invoice.png',
          '发票管理',
        ),
        onTap: () {
          Get.toNamed(AppRoutes.invoiceManage);
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
          invoiceSection
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
