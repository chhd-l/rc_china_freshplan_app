import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rc_china_freshplan_app/common/util/utils.dart';
import 'package:rc_china_freshplan_app/common/values/colors.dart';
import 'package:rc_china_freshplan_app/common/widgets/factor.dart';
import 'package:rc_china_freshplan_app/data/address.dart';

Widget commonContainer(Widget child, {EdgeInsetsGeometry? padding}) {
  return Container(
    padding: padding ?? const EdgeInsets.all(16),
    margin: const EdgeInsets.only(bottom: 15),
    decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 0),
              color: Color.fromRGBO(191, 191, 191, 0.1),
              blurRadius: 2.0,
              blurStyle: BlurStyle.solid,
              spreadRadius: 0.0)
        ]),
    child: child,
  );
}

Widget addressContainer(VoidCallback onPress, AddRess address) {
  return commonContainer(GestureDetector(
    onTap: onPress,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset('assets/images/address.png'),
        const SizedBox(width: 8),
        Expanded(
            child: address.receiverName != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(address.receiverName!,
                              style: textSyle700(
                                  fontSize: 15,
                                  color: AppColors.text222)),
                          const SizedBox(width: 8),
                          Text(address.phone!,
                              style: textSyle700(
                                  fontSize: 15, color: AppColors.text999)),
                        ],
                      ),
                      Text(
                          address.province! +
                              address.city! +
                              address.region! +
                              address.detail!,
                          style: textSyle700(fontSize: 13)),
                    ],
                  )
                : Text(
                    '??????????????????',
                    style: textSyle700(fontSize: 17, color: AppColors.text333),
                  )),
        Image.asset('assets/images/arrow-right.png'),
      ],
    ),
  ));
}

Widget orderProductContainer(List orderProduct, int productTotalPrice) {
  return commonContainer(Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('????????????', style: textSyle700(fontSize: 16)),
      ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: orderProduct.length,
          itemBuilder: (context, index) {
            final item = orderProduct[index];
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedNetworkImage(
                  imageUrl: item["variants"][0]["defaultImage"],
                  placeholder: (context, url) => Image.asset(
                    'assets/images/?????????.png',
                    fit: BoxFit.cover,
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/images/?????????.png',
                    fit: BoxFit.cover,
                  ),
                  width: 89,
                  height: 89,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      Text(item['name'],
                          style: textSyle700(
                              fontSize: 14, color: AppColors.text333)),
                      Text(
                          handlePrice(item["variants"][0]['subscriptionPrice']),
                          style: textSyle700(
                              fontSize: 12, color: AppColors.text999)),
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text('X6',
                        style: textSyle700(
                            fontSize: 10, color: AppColors.text999))),
              ],
            );
          }),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          RichText(
            textAlign: TextAlign.end,
            text: TextSpan(
                style: textSyle700(fontSize: 14, color: AppColors.text666),
                children: [
                  const TextSpan(text: '???????????????'),
                  TextSpan(
                    text: handlePrice(productTotalPrice),
                    style: const TextStyle(color: AppColors.primaryText),
                  ),
                ]),
          ),
        ],
      )
    ],
  ));
}

Widget priceRow(String left, int right,
    {bool discount = false, bool isPrice = true, String rightText = ''}) {
  return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(left,
              style: textSyle700(fontSize: 14, color: AppColors.text666)),
          Text(isPrice ? handlePrice(right, isDiscount: discount) : rightText,
              style: textSyle700(fontSize: 14, color: AppColors.text333)),
        ],
      ));
}
