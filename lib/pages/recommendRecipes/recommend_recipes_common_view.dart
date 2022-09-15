import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rc_china_freshplan_app/common/values/colors.dart';
import 'package:rc_china_freshplan_app/common/widgets/factor.dart';

Widget recipesItem(
    bool isSelected, String assets, String title, String description) {
  return Container(
    margin: const EdgeInsets.only(bottom: 24),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        border: Border.all(
            color: isSelected
                ? const Color.fromRGBO(150, 204, 57, 1)
                : Colors.white),
        boxShadow: const [
          BoxShadow(
              offset: Offset(0, 0),
              color: Color.fromRGBO(85, 134, 1, 0.2),
              blurRadius: 4.0,
              blurStyle: BlurStyle.solid,
              spreadRadius: 0.0)
        ]),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CachedNetworkImage(
          imageUrl: assets,
          placeholder: (context, url) => Image.asset(
            'assets/images/牛肉泥.png',
            fit: BoxFit.cover,
          ),
          errorWidget: (context, url, error) => Image.asset(
            'assets/images/牛肉泥.png',
            fit: BoxFit.cover,
          ),
          width: 89,
          height: 89,
        ),
        // Image.asset(assets),
        Expanded(
            child: Container(
          margin: const EdgeInsets.only(left: 8),
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: textSyle700(
                    fontSize: 18, color: const Color.fromRGBO(7, 7, 7, 1)),
              ),
              Text(
                description
                    .replaceAll('<p>', '')
                    .replaceAll('</p>', '')
                    .replaceAll('<br>', '')
                    .replaceAll('</br>', ''),
                style: textSyle700(fontSize: 13, color: AppColors.text999),
              ),
            ],
          ),
        )),
        isSelected
            ? Image.asset('assets/images/checkbox-selected.png')
            : Image.asset('assets/images/checkbox.png')
      ],
    ),
  );
}

Widget richText(String title1, String title2, String title3) {
  return RichText(
    textAlign: TextAlign.start,
    text: TextSpan(
        style: textSyle700(fontSize: 16, color: AppColors.text333),
        children: [
          TextSpan(text: title1),
          TextSpan(
            text: title2,
            style: const TextStyle(
                fontSize: 16, color: Color.fromRGBO(150, 204, 57, 1)),
          ),
          TextSpan(text: title3),
        ]),
  );
}
