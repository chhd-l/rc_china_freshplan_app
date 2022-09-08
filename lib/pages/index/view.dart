import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rc_china_freshplan_app/common/widgets/factor.dart';
import 'package:rc_china_freshplan_app/common/values/colors.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/common/router/app_router.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(color: AppColors.primaryBackground),
          child: Column(children: [
            const SizedBox(height: 60),
            Image.asset('assets/images/fresh-plan-logo.png'),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 36),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset('assets/images/pet.png'),
                  const SizedBox(width: 10),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('为爱宠探索定制鲜食体验',
                          style: textSyle900(fontSize: 24, height: 1)),
                      const SizedBox(height: 12),
                      Text(
                        '新鲜完整的食材，用心将鲜食做到极致，精准定制方案',
                        style: textSyle400(fontSize: 17.5),
                      ),
                      const SizedBox(height: 12),
                      Text('仅需30秒哦~', style: textSyle400(fontSize: 14)),
                    ],
                  )),
                ],
              ),
            ),
            Image.asset('assets/images/fresh-plan-1.png'),
            // Expanded(
            //     child: Swiper.children(
            //         autoplay: true,
            //         containerHeight: 100,
            //         scrollDirection: Axis.horizontal,
            //         children: [
            //       Image.asset('assets/images/fresh-plan-1.png'),
            //       Image.asset('assets/images/fresh-plan-2.png'),
            //     ])),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
              child: titleButton('定制鲜粮', () {
                Get.toNamed(AppRoutes.createPet);
              },
                  isCircle: true,
                  icon: Container(
                    padding: const EdgeInsets.only(right: 12),
                    child: Image.asset('assets/images/time.png'),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24, bottom: 24),
              child: Image.asset('assets/images/arrow-bottom.png'),
            ),
            Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(2.5, 2.5),
                        color: Color.fromRGBO(85, 134, 1, 0.1),
                        blurRadius: 2.0,
                        blurStyle: BlurStyle.solid,
                        spreadRadius: 0.0)
                  ]),
              padding: const EdgeInsets.fromLTRB(32, 19, 32, 19),
              child: Column(
                children: [
                  titleLine('仅三步即可开启鲜食计划'),
                  const SizedBox(height: 32),
                  Image.asset('assets/images/fresh-plan-step.png')
                ],
              ),
            ),
            const SizedBox(height: 38),
            Image.asset('assets/images/fresh-plan-diet.png'),
            Container(
              transform: Matrix4.translationValues(0, -84, 0),
              padding: const EdgeInsets.fromLTRB(64, 19, 56, 0),
              child: titleButton('查看饮食', () {}, isCircle: true),
            ),
            titleLine('专业的科研团队\n 时刻守护您的爱宠健康'),
            Container(
              padding: const EdgeInsets.fromLTRB(45, 24.5, 45, 0),
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(2.5, 2.5),
                          color: Color.fromRGBO(85, 134, 1, 0.1),
                          blurRadius: 2.0,
                          blurStyle: BlurStyle.solid,
                          spreadRadius: 0.0)
                    ]),
                padding: const EdgeInsets.fromLTRB(28, 22, 28, 22),
                child: Column(
                  children: [
                    Image.asset('assets/images/doctor-avatar.png'),
                    const SizedBox(height: 12),
                    Text(
                      'DR. JUSTIN\nSHMALBERG',
                      style: textSyle800(
                          fontSize: 18, color: AppColors.secondText),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text('首席科研医疗官',
                        style: textSyle800(
                            fontSize: 15, color: AppColors.secondText)),
                    const SizedBox(height: 21),
                    Text(
                        'Shmalberg博士是美国不到100名委员会认证的兽医营养师之一，同时也是一所著名兽医学院的临床副教授。他指导Fresh Plan的所有配方，并为宠物营养提供建议',
                        style: textSyle800(
                            fontSize: 13, color: AppColors.secondText)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 46),
            titleLine('常见问题为您提供解答'),
            const SizedBox(height: 6),
            answerChild('谁制定你的食谱?',
                '我们的员工中有两名委员会认证的兽医营养师，负责监督每一份食谱的制作--这是在整个国家大约100个中的两个。他们（与我们的博士领导的科研团队一起）也在宠物微生物组研究领域处于领先地位。'),
            answerChild('是什么让你的食物与众不同?',
                '它是干净的，没有杂质，没有化学成分。我们使用新鲜、完整的营养成分，能够很好的照顾到过敏和敏感体质。'),
            answerChild('Fresh Plan是如何准备的?',
                '每种肉类和蔬菜都是单独轻柔地烹调，然后分批混合，以密封重要的营养物质并最大限度地提高消化率。这就是为什么牛肉看起来像牛肉，豌豆看起来像豌豆。'),
            const SizedBox(height: 32),
            Image.asset(
              'assets/images/fresh-plan-3.png',
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
          ]),
        ),
      ),
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
        currentIndex: 0,
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

Widget horizontalLine() {
  return Container(
      width: 66.5,
      height: 4.5,
      decoration: const BoxDecoration(
          color: AppColors.tint,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          )));
}

Widget titleLine(String title) {
  return Column(
    children: [
      Text(title,
          style: textSyle700(fontSize: 24), textAlign: TextAlign.center),
      const SizedBox(height: 8),
      horizontalLine(),
    ],
  );
}

Widget answerChild(String title, String content) {
  return Container(
    padding: const EdgeInsets.fromLTRB(15, 13, 15, 0),
    child: Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
                offset: Offset(2.5, 2.5),
                color: Color.fromRGBO(85, 134, 1, 0.1),
                blurRadius: 2.0,
                blurStyle: BlurStyle.solid,
                spreadRadius: 0.0)
          ]),
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('assets/images/pet-circle.png'),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: const EdgeInsets.only(left: 8),
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/rectangle.png'),
                          fit: BoxFit.fill)),
                  child: Text(title,
                      style: textSyle700(
                          fontSize: 14, color: AppColors.secondText))),
              Padding(
                padding: const EdgeInsets.only(left: 8, top: 8),
                child: Text(content,
                    style:
                        textSyle700(fontSize: 13, color: AppColors.threeText)),
              ),
            ],
          ))
        ],
      ),
    ),
  );
}
