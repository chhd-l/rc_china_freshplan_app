import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/common/router/app_router.dart';
import 'package:rc_china_freshplan_app/data/pet.dart';

import '../../account/common-view.dart';

Widget petItem(Pet pet, Pet selectPet) {
  return SizedBox(
    height: 80,
    width: 80,
    child: Column(
      children: [
        Stack(
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
            Positioned(
              right: 0,
              child: Image.asset(
                  'assets/images/pet-type-${selectPet == pet ? 'selected' : 'select'}.png'),
            )
          ],
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
}

Widget petSection(Widget child) {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Colors.white,
      boxShadow: const [
        BoxShadow(
            color: Color.fromRGBO(223, 223, 223, 0.5),
            offset: Offset(0.0, 6.0), //阴影xy轴偏移量
            blurRadius: 15.0, //阴影模糊程度
            spreadRadius: 1.0 //阴影扩散程度
            )
      ],
    ),
    child: Column(
      children: [
        GestureDetector(
          child: commonBoxTitle('assets/images/petfoot-icon.png', '我的宠物',
              subTitle: '添加宠物'),
          onTap: () {
            Get.toNamed(AppRoutes.createPet);
          },
        ),
        Container(padding: const EdgeInsets.only(bottom: 20), child: child)
      ],
    ),
  );
}
