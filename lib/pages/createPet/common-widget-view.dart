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
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ))),
      const SizedBox(width: 10),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: textSyle700(fontSize: 18, height: 1),
              ),
              if (subTitle != null)
                Text(subTitle,
                    style: textSyle700(
                        fontSize: 13,
                        color: const Color.fromRGBO(153, 153, 153, 1)))
            ],
          ),
          if (description != null)
            Text(description,
                style: textSyle700(
                    fontSize: 13,
                    color: const Color.fromRGBO(102, 102, 102, 1)))
        ],
      )
    ],
  );
}

Widget selectBox({VoidCallback? onPressed, String? value}) {
  return GestureDetector(
    onTap: onPressed ?? () {},
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
          color: Color.fromRGBO(246, 246, 246, 1),
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          )),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          value != null && value != '' ? value : '请选择',
          style: textSyle700(fontSize: 15),
        ),
        Image.asset('assets/images/arrow-right.png'),
      ]),
    ),
  );
}

Widget petTypeBox(bool isSelected, String petType, VoidCallback onPressed) {
  final selected = isSelected == true ? 'selected' : 'select';
  return Column(
    children: [
      GestureDetector(
        onTap: onPressed,
        child: Container(
          width: 89,
          height: 89,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/pet-$selected.png'))),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Image.asset(
              'assets/images/$petType.png',
              fit:BoxFit.contain,
              height: petType == 'dog' ? 20 : 40,
              width:60,
            ),
          ),
        ),
      ),
      const SizedBox(height: 20),
      Text(
        petType == 'dog' ? '狗狗' : '猫猫',
        style: textSyle700(
            fontSize: 16, color: const Color.fromRGBO(153, 153, 153, 1)),
      )
    ],
  );
}

Widget genderBox(bool isSelected, String gender, VoidCallback onPressed) {
  return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 160,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: isSelected
                ? AppColors.tint
                : const Color.fromRGBO(246, 246, 246, 1),
            borderRadius: const BorderRadius.all(Radius.circular(15))),
        child: Text(gender,
            style: textSyle700(
                fontSize: 15,
                color: isSelected ? Colors.white : AppColors.primaryText)),
      ));
}

Widget verticalOptions(List titles, Function callBack) {
  final List<Widget> widgets = titles
      .asMap()
      .entries
      .map((e) => Container(
            padding: const EdgeInsets.only(bottom: 10),
            child: titleButton(e.value, () {
              callBack(e.value, e.key);
            }),
          ))
      .toList();

  return _bottomOption(
      Column(children: widgets), const EdgeInsets.fromLTRB(24, 22, 24, 0));
}

Widget _bottomOption(Widget widget, EdgeInsets padding) {
  return Container(
    decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.tabCellSeparator, width: 1.0),
        ),
        color: Colors.white),
    padding: padding,
    child: SafeArea(
      child: widget,
    ),
  );
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
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: isSelected
                ? const Color.fromRGBO(224, 241, 196, 1)
                : const Color.fromRGBO(246, 246, 246, 1),
            borderRadius: status == 'thin'
                ? const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15))
                : status == 'overweight'
                    ? const BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15))
                    : const BorderRadius.all(Radius.circular(0))),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Image.asset('assets/images/$status.png'),
            const SizedBox(height: 8),
            Text(
              title,
              style: textSyle400(fontSize: 14),
            )
          ],
        ),
      ));
}

Widget petAvatarPick(VoidCallback onPress, String petAvatar) {
  return GestureDetector(
    onTap: onPress,
    child: Container(
      width: 89,
      height: 89,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/select-pet-avatar.png'))),
      child: ClipOval(
          child: SizedBox(
        height: 64,
        width: 64,
        child: petAvatar != ''
            ? CachedNetworkImage(
                imageUrl:
                    petAvatar != '' ? petAvatar : 'assets/images/pet-gray.png',
                placeholder: (context, url) => Image.asset(
                  'assets/images/pet-gray.png',
                  fit: BoxFit.cover,
                ),
                errorWidget: (context, url, error) => Image.asset(
                  'assets/images/pet-gray.png',
                  fit: BoxFit.cover,
                ),
                fit: BoxFit.cover,
              )
            : Image.asset('assets/images/pet-gray.png'),
      )),
    ),
  );
}
