import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/common/router/app_router.dart';

import '../common/widgets/factor.dart';

class RecipesPage extends StatelessWidget {
  RecipesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        // const SizedBox(height: 12),
        //   Image.asset('assets/images/fresh-plan-logo.png'),
        //   const SizedBox(height: 6),
        body: SafeArea(
            child: Column(
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Image.asset('assets/images/fresh-plan-logo.png')),
        Expanded(
            child: SingleChildScrollView(
                child: Image.asset('assets/images/recipes_page.png'))),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 40, 20, 8),
          child: titleButton('定制鲜粮', () {
            Get.toNamed(AppRoutes.choosePet);
          },
              isCircle: true,
              icon: Container(
                padding: const EdgeInsets.only(right: 12),
                child: Image.asset('assets/images/time.png'),
              )),
        )
      ],
    )));
  }
}
