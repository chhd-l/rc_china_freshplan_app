import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/common/router/app_router.dart';

class PetDetailPage extends StatelessWidget {
  const PetDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      body: Container(
        padding: const EdgeInsets.all(15),
        child: const Text("test pet detail page"),
      ),
    );
  }
}
