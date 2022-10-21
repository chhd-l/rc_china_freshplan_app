import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/common/util/utils.dart';
import 'package:rc_china_freshplan_app/common/widgets/factor.dart';

import '../../common/router/app_router.dart';
import '../../common/values/colors.dart';

Widget buildSubscriptionListView(List subscriptionList) {
  return SizedBox(
      height: 540,
      child: Swiper(
          pagination: const SwiperPagination(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(bottom: 0),
              builder: DotSwiperPaginationBuilder(
                activeColor: Colors.white,
                color: AppColors.text999,
              )),
          itemCount: subscriptionList.length,
          itemBuilder: (context, index) {
            final item = subscriptionList[index];
            final pet = subscriptionList[index]["pet"];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/pet.png',
                      height: 24,
                      width: 24,
                    ),
                    const SizedBox(width: 10),
                    Text(item["pet"]["name"] ?? '',
                        style:
                            textSyle400(fontSize: 24, color: AppColors.tint)),
                    Text('的专属鲜食食谱',
                        style: textSyle400(
                            fontSize: 24, color: AppColors.text222)),
                  ],
                ),
                const SizedBox(height: 28),
                Container(
                  width: 340,
                  height: 195,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/plan-title-bg.png'),
                          fit: BoxFit.fitWidth)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 2),
                        child: Text(
                          'FRESH编号：${item["no"]}',
                          style: textSyle400(
                              fontSize: 11,
                              color: const Color.fromRGBO(99, 148, 14, 1)),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 12, left: 12, right: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: item["pet"]["image"],
                                placeholder: (context, url) => Image.asset(
                                  item["pet"]["type"] == 'CAT'
                                      ? 'assets/images/cat.png'
                                      : 'assets/images/dog.png',
                                ),
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  item["pet"]["type"] == 'CAT'
                                      ? 'assets/images/cat.png'
                                      : 'assets/images/dog.png',
                                ),
                                width: 61,
                                height: 61,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item["pet"]["name"] ?? '',
                                    style: textSyle400(
                                        fontSize: 18, color: Colors.white)),
                                const SizedBox(height: 7),
                                Row(
                                  children: [
                                    Text(
                                        "${pet["recentHealth"] == 'EMACIATED' ? '瘦弱' : item["pet"]["OBESITY"] == 'OBESITY' ? '超重' : '标准'}体重",
                                        style: textSyle400(
                                            fontSize: 13, color: Colors.white)),
                                    const SizedBox(width: 10),
                                    Text(
                                        getAgeYear(handleDateFromApi(
                                            item["pet"]["birthday"])),
                                        style: textSyle400(
                                            fontSize: 13, color: Colors.white)),
                                  ],
                                ),
                                const SizedBox(height: 7),
                                Row(
                                  children: [
                                    Text(item["pet"]["breedName"] ?? '',
                                        style: textSyle400(
                                            fontSize: 13, color: Colors.white)),
                                    const SizedBox(width: 16),
                                    Text("${pet["recentWeight"]}kg",
                                        style: textSyle400(
                                            fontSize: 13, color: Colors.white)),
                                  ],
                                ),
                              ],
                            )),
                            Icon(
                              item["pet"]["gender"] == 'MALE'
                                  ? Icons.male
                                  : Icons.female,
                              size: 30,
                              color: const Color.fromRGBO(255, 227, 185, 1),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 32),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            titleButton('管理计划', () {
                              Get.toNamed(AppRoutes.subscriptionDetail,
                                  arguments: item["id"] ?? '');
                            },
                                bgColor: Colors.white,
                                fontSize: 13,
                                fontColor: AppColors.tint,
                                width: 240,
                                height: 36,
                                isCircle: true)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: 340,
                  height: 240,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image:
                              AssetImage('assets/images/plan-content-bg.png'),
                          fit: BoxFit.cover)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 40, left: 36, right: 12),
                        child: Row(
                          children: [
                            Container(
                                width: 63,
                                height: 63,
                                decoration:
                                    const BoxDecoration(color: Colors.white),
                                child: CachedNetworkImage(
                                  imageUrl: item["productList"] != null &&
                                          item["productList"].length > 0
                                      ? item["productList"][0]["variants"]
                                          ["defaultImage"]
                                      : 'assets/images/牛肉泥.png',
                                  placeholder: (context, url) =>
                                      Image.asset('assets/images/牛肉泥.png'),
                                  errorWidget: (context, url, error) =>
                                      Image.asset('assets/images/牛肉泥.png'),
                                  width: 61,
                                  height: 61,
                                  fit: BoxFit.cover,
                                )),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    item["productList"] != null &&
                                            item["productList"].length > 0
                                        ? item["productList"][0]["name"]
                                        : '',
                                    style: textSyle400(
                                        fontSize: 14,
                                        color: const Color.fromRGBO(
                                            34, 34, 34, 1))),
                                const SizedBox(height: 10),
                                SizedBox(
                                  width: 180,
                                  child: Text(
                                      item["productList"] != null &&
                                              item["productList"].length > 0
                                          ? (item["productList"][0]
                                                  ["description"])
                                              .replaceAll('<p>', '')
                                              .replaceAll('</p>', '')
                                              .replaceAll('<br>', '')
                                              .replaceAll('</br>', '')
                                          : '',
                                      style: textSyle400(
                                          fontSize: 11,
                                          color: AppColors.text666)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                          padding: EdgeInsets.only(
                              top: 10, bottom: 10, right: 18, left: 18),
                          child: Divider(
                              color: Color.fromARGB(255, 168, 220, 80))),
                      Padding(
                        padding: const EdgeInsets.only(left: 36, right: 12),
                        child: Row(
                          children: [
                            Container(
                              width: 63,
                              height: 63,
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              child: Image.asset(
                                'assets/images/delivery-house.png',
                                width: 61,
                                height: 61,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('发货驿站',
                                    style: textSyle400(
                                        fontSize: 14,
                                        color: const Color.fromRGBO(
                                            34, 34, 34, 1))),
                                const SizedBox(height: 10),
                                RichText(
                                  text: TextSpan(
                                      style: textSyle700(
                                          fontSize: 11,
                                          color: const Color.fromRGBO(
                                              34, 34, 34, 1)),
                                      children: [
                                        const TextSpan(text: '下一次将在'),
                                        TextSpan(
                                          text: handleDateFromApi(
                                              item["createNextDeliveryTime"]),
                                          style: const TextStyle(
                                              color: Color.fromRGBO(
                                                  246, 156, 50, 1)),
                                        ),
                                        const TextSpan(text: '发货\n请注意查收!'),
                                      ]),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          }));
}

Widget buildNoSubscriptionView() {
  return SizedBox(
      height: 600,
      child: Swiper(
          pagination: const SwiperPagination(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(bottom: 0),
              builder: DotSwiperPaginationBuilder(
                activeColor: Colors.white,
                color: AppColors.text999,
              )),
          itemCount: 2,
          itemBuilder: (context, index) {
            return Image.asset(
              index == 0
                  ? 'assets/images/fresh-plan-1.png'
                  : 'assets/images/fresh-plan-2.png',
              fit: BoxFit.fitWidth,
            );
          }));
}
