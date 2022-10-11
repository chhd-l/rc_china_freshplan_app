import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/common/widgets/factor.dart';

import '../../common/router/app_router.dart';
import '../../data/pet.dart';

Widget commonBoxTitle(String icon, String title, {String subTitle = ''}) {
  return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            icon,
            width: 20,
            height: 20,
            fit: BoxFit.fitWidth,
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              child: Text(
                title,
                style: const TextStyle(
                  color: Color.fromARGB(255, 34, 34, 34),
                  fontSize: 15,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 5),
            child: Text(subTitle,
                style: const TextStyle(
                  color: Color.fromARGB(255, 153, 153, 153),
                  fontSize: 12,
                )),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: Color.fromARGB(255, 153, 153, 153),
            size: 12,
          ),
        ],
      ));
}

Widget petItemView(Pet pet) {
  return SizedBox(
    height: 80,
    width: 90,
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
}

Widget addPetIconView() {
  return GestureDetector(
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
  );
}

Column buildOrderItem(String img, String label, int quantity) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Stack(
        children: [
          SizedBox(
              width: 40,
              height: 40,
              child: Image.asset(
                img,
                width: 27,
                height: 27,
              )),
          quantity > 0
              ? Positioned(
                  left: 20,
                  bottom: 25,
                  child: Container(
                    padding: const EdgeInsets.only(left: 2, right: 2),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 66, 81),
                        borderRadius: BorderRadius.circular(12)),
                    child: Text(
                      quantity > 99 ? '99+' : quantity.toString(),
                      style: textSyle700(color: Colors.white, fontSize: 10),
                    ),
                  ),
                )
              : Container()
        ],
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

Widget buildEmpltyPetListRegion() {
  return Row(
    children: [
      addPetIconView(),
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
