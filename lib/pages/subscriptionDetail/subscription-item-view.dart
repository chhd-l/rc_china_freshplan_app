import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/common/router/app_router.dart';
import 'package:rc_china_freshplan_app/common/util/utils.dart';
import 'package:rc_china_freshplan_app/common/values/colors.dart';
import 'package:rc_china_freshplan_app/common/widgets/factor.dart';

Widget subCommonBox(String icon, String title, Widget child,
    {String? subTitle = ''}) {
  return Container(
    padding: const EdgeInsets.all(15),
    margin: const EdgeInsets.only(bottom: 15),
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(8)),
      boxShadow: [
        BoxShadow(
            color: Color.fromRGBO(191, 191, 191, 0.1),
            offset: Offset(0.0, 6.0), //阴影xy轴偏移量
            blurRadius: 15.0, //阴影模糊程度
            spreadRadius: 1.0 //阴影扩散程度
            )
      ],
    ),
    child: Column(
      children: [
        Row(
          children: [
            Image.asset(icon),
            const SizedBox(width: 10),
            Expanded(
                child: Text(
              title,
              style: textSyle400(fontSize: 15, color: AppColors.text222),
            )),
            Text(
              subTitle ?? '',
              style: textSyle400(fontSize: 12, color: AppColors.text666),
            )
          ],
        ),
        const SizedBox(height: 12),
        const Divider(color: Color.fromRGBO(226, 226, 226, 1)),
        const SizedBox(height: 12),
        child
      ],
    ),
  );
}

Widget subProductItem(item) {
  return Row(
    children: [
      Container(
          width: 73,
          height: 73,
          decoration: const BoxDecoration(
              color: AppColors.baseGray,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: CachedNetworkImage(
            imageUrl:
                item["variants"]["defaultImage"] ?? 'assets/images/牛肉泥.png',
            placeholder: (context, url) => Image.asset('assets/images/牛肉泥.png'),
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
          Text(item["name"] ?? '牛肉泥',
              style: textSyle400(fontSize: 15, color: AppColors.text333)),
          const SizedBox(height: 10),
          Text(
              (item["description"] ?? '牛肉、土豆、鸡蛋、胡萝卜、豌豆')
                  .replaceAll('<p>', '')
                  .replaceAll('</p>', '')
                  .replaceAll('<br>', '')
                  .replaceAll('</br>', ''),
              style: textSyle400(fontSize: 13, color: AppColors.text666)),
        ],
      ),
    ],
  );
}

Widget buildSubPetView(pet) {
  final defaultImage =
      pet["type"] == 'CAT' ? 'assets/images/cat.png' : 'assets/images/dog.png';
  return subCommonBox(
    "assets/images/petfoot-icon.png",
    '我的宠物',
    GestureDetector(
        onTap: () {
          Get.toNamed(AppRoutes.petDetail, arguments: pet["id"] ?? '');
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipOval(
              child: CachedNetworkImage(
                imageUrl: pet["image"],
                placeholder: (context, url) => Image.asset(defaultImage),
                errorWidget: (context, url, error) => Image.asset(defaultImage),
                width: 61,
                height: 61,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(pet["name"] ?? '球球',
                        style: textSyle400(
                            fontSize: 15, color: AppColors.text222)),
                    Icon(
                      pet["gender"] == 'MALE' ? Icons.male : Icons.female,
                      size: 30,
                      color: const Color.fromRGBO(255, 227, 185, 1),
                    )
                  ],
                ),
                const SizedBox(height: 7),
                Row(
                  children: [
                    Text(pet["breedName"] ?? '英国短毛猫',
                        style: textSyle400(
                            fontSize: 12, color: AppColors.text999)),
                    const SizedBox(width: 10),
                    Text(getAgeYear(handleDateFromApi(pet["birthday"])) ?? '',
                        style: textSyle400(
                            fontSize: 12, color: AppColors.text999)),
                  ],
                ),
              ],
            )),
            Image.asset('assets/images/arrow-right.png'),
          ],
        )),
  );
}

Widget buildSubPlanProductView(subNo, planProductList) {
  return subCommonBox(
      "assets/images/plan-product-icon.png",
      "计划商品",
      ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: planProductList.length,
          itemBuilder: (BuildContext ctx, int i) {
            var item = planProductList[i];
            return subProductItem(item);
          }),
      subTitle: '计划编号：${subNo ?? '20185275063697'}');
}

Widget buildSubRecommendProductView(recommendProductList) {
  return subCommonBox(
    "assets/images/recommend-product-icon.png",
    "推荐商品",
    Column(
      children: [
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: recommendProductList.length,
            itemBuilder: (BuildContext ctx, int i) {
              var item = recommendProductList[i];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: subProductItem(item),
              );
            }),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            titleButton("更换", () {},
                width: 100,
                height: 36,
                bgColor: Colors.white,
                fontColor: AppColors.tint,
                borderColor: AppColors.tint,
                isCircle: true)
          ],
        )
      ],
    ),
  );
}

Widget buildSubDeliveryHouseView(deliveryTime, isCancel, subId) {
  return subCommonBox(
    "assets/images/delivery-house-icon.png",
    "发货驿站",
    Column(
      children: [
        Row(
          children: [
            Image.asset(isCancel
                ? 'assets/images/cancel-delivery-house-icon.png'
                : 'assets/images/delivery-house.png'),
            const SizedBox(width: 10),
            SizedBox(
              width: 240,
              child: Text(
                isCancel ? "本次Fresh plan已取消" : '下一次将在$deliveryTime发货，请注意查收!',
                style: textSyle700(color: AppColors.text222),
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            titleButton(isCancel ? "查看详情" : "计划进度", () {
              Get.toNamed(AppRoutes.planDetail, arguments: subId);
            },
                width: 100,
                height: 36,
                bgColor: Colors.white,
                fontColor: AppColors.tint,
                borderColor: AppColors.tint,
                isCircle: true)
          ],
        )
      ],
    ),
  );
}

Widget buildSubPayInfoView(source, phone) {
  return subCommonBox(
    "assets/images/pay-info-icon.png",
    "签约信息",
    Column(
      children: [
        Row(
          children: [
            Image.asset('assets/images/pay-way-icon.png'),
            const SizedBox(width: 10),
            Text(
              '签约平台：${source == 'WECHAT_MINI_PROGRAM' ? '微信' : '支付宝'}',
              style: textSyle700(color: AppColors.text222),
            )
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Image.asset('assets/images/pay-user-icon.png'),
            const SizedBox(width: 10),
            Text(
              '签约账户：$phone',
              style: textSyle700(color: AppColors.text222),
            )
          ],
        )
      ],
    ),
  );
}
