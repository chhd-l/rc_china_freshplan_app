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
              fit: BoxFit.fitHeight,
              height: 40,
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
