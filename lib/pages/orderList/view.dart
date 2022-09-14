import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/common/router/app_router.dart';

class OrderList extends StatelessWidget {
  const OrderList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('订单列表', selectionColor: Colors.black,),
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
        body:Container(
          padding: const EdgeInsets.all(12),
          color:const Color.fromARGB(255, 249, 249, 249),
          child:  ListView.builder(
              shrinkWrap: true,
              itemCount: 1,
              itemBuilder: (BuildContext ctx, int i) {
                return const Text('xxxx');
              },
          ),
        ),
    );
  }
}
