import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/common/router/app_router.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget loginSection = Container(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Row(children: [
        ClipOval(
          child: Image.asset(
            'assets/images/unlogin.png',
            width: 55,
            height: 55,
            fit: BoxFit.cover,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 10),
          child: const Text(
            '点击登录',
            style: TextStyle(
              fontSize: 22,
              color: Color.fromARGB(255, 51, 51, 51),
            ),
          ),
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
          Container(
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
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildOrderItem('assets/images/unpaid-icon.png', '待付款'),
                buildOrderItem('assets/images/unship-icon.png', '待发货'),
                buildOrderItem('assets/images/shipped-icon.png', '待收货'),
              ],
            ),
          )
        ],
      ),
    );

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
            child: Row(
              children: [
                Container(
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
                Expanded(
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
                ),
              ],
            ),
          )
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
      body: Container(
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
      ),
    );
  }
}
