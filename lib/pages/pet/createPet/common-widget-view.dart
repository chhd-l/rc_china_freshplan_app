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

Widget selectBox() {
  return GestureDetector(
    child: Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
          color: Color.fromRGBO(246, 246, 246, 1),
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          )),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          '请选择',
          style: textSyle700(fontSize: 15),
        ),
        Image.asset('assets/images/arrow-right.png'),
      ]),
    ),
  );
}