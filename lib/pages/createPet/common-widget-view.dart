import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rc_china_freshplan_app/common/values/colors.dart';
import 'package:rc_china_freshplan_app/common/widgets/factor.dart';

Widget commonTitle(String title, {String? description, String? subTitle}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
          width: 4,
          height: 18.5,
          decoration: const BoxDecoration(
              color: AppColors.tint,
              borderRadius: BorderRadius.all(Radius.circular(15)))),
      const SizedBox(width: 10),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(title, style: textSyle700(fontSize: 18, height: 1)),
              if (subTitle != null)
                Text(subTitle,
                    style: textSyle700(fontSize: 13, color: AppColors.text999))
            ],
          ),
          if (description != null)
            Text(description,
                style: textSyle700(fontSize: 13, color: AppColors.text666))
        ],
      )
    ],
  );
}

Widget selectBox(
    {VoidCallback? onPressed,
    String? value,
    Color? bgColor,
    Color? fontColor}) {
  return GestureDetector(
    onTap: onPressed ?? () {},
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: bgColor ?? AppColors.baseGray,
          borderRadius: const BorderRadius.all(Radius.circular(15))),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          value != null && value != '' ? value : '请选择',
          style: textSyle700(
              fontSize: 15, color: fontColor ?? AppColors.primaryText),
        ),
        // Image.asset('assets/images/arrow-right.png'),
        Icon(
          Icons.arrow_forward_ios,
          size: 15,
          color: fontColor ?? AppColors.primaryText,
        )
      ]),
    ),
  );
}

Widget genderBox(bool isSelected, String gender, VoidCallback onPressed,
    {Color? bgColor}) {
  return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 160,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: isSelected ? AppColors.tint : bgColor ?? AppColors.baseGray,
            borderRadius: const BorderRadius.all(Radius.circular(15))),
        child: Text(gender,
            style: textSyle700(
                fontSize: 15,
                color: isSelected ? Colors.white : AppColors.primaryText)),
      ));
}

Widget fixBottomContainer(Widget child) {
  return Container(
    decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.tabCellSeparator, width: 1.0),
        ),
        color: Colors.white),
    padding: const EdgeInsets.fromLTRB(24, 19, 24, 19),
    child: child,
  );
}

Widget statusBox(
    bool isSelected, String status, String title, VoidCallback onPressed) {
  return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 112,
        decoration: BoxDecoration(
            color: isSelected
                ? const Color.fromRGBO(224, 241, 196, 1)
                : AppColors.baseGray,
            borderRadius: isSelected
                ? const BorderRadius.all(Radius.circular(15))
                : const BorderRadius.all(Radius.circular(0))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/$status.png'),
            const SizedBox(height: 8),
            Text(title, style: textSyle400(fontSize: 14))
          ],
        ),
      ));
}

Widget petAvatarPick(VoidCallback onPress, String petAvatar,
    {String? childAsset = 'assets/images/pet-gray.png',
    String? pickAsset = 'assets/images/camera.png',
    Color? bgColor = const Color.fromRGBO(239, 239, 240, 1)}) {
  return GestureDetector(
      onTap: onPress,
      child: Stack(alignment: Alignment.center, children: [
        ClipOval(
            child: Container(
                width: 89,
                height: 89,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(89)),
                  color: bgColor,
                ),
                child: petAvatar != ''
                    ? CachedNetworkImage(
                        imageUrl: petAvatar != ''
                            ? petAvatar
                            : 'assets/images/pet-gray.png',
                        fit: BoxFit.cover,
                      )
                    : Image.asset(childAsset!))),
        Positioned(
          right: 2,
          bottom: 2,
          child: Image.asset(pickAsset!),
        )
      ]));
}

Widget buildProgressView(int currentStep) {
  return SizedBox(
    height: 60,
    child: Stack(
      children: [
        // 下面的背景盒子
        Container(
          height: 8,
          width: 400,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: Color.fromRGBO(206, 234, 158, 1),
          ),
        ),
        // 上面的进度条盒子
        Container(
          height: 8,
          width: 50 * currentStep.toDouble(), // 动态更改进度条盒子的宽度即可
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: Color.fromRGBO(150, 204, 57, 1),
          ),
        ),
        Positioned(
            left: 48 * currentStep.toDouble(),
            top: 10,
            child: Text(
              '${13 * currentStep}%',
              style: textSyle400(color: AppColors.tint),
            ))
      ],
    ),
  );
}
