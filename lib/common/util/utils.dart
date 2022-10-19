import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rc_china_freshplan_app/common/values/colors.dart';
import 'package:rc_china_freshplan_app/common/widgets/factor.dart';

handlePrice(value, {isDiscount = false}) {
  if (value == null) {
    return '';
  }
  return isDiscount ? '-￥$value.00' : '￥$value.00';
}

handleDateTimeToZone(DateTime time) {
  return '${time.toIso8601String().split('.')[0]}.000Z';
}

handleDateFromApi(date) {
  return DateFormat('yyyy-MM-dd')
      .format(DateTime.parse(date ?? DateTime.now().toString()));
}

getAgeYear(birthdayStr) {
  if (birthdayStr == '' || birthdayStr == null) {
    return '';
  }
  var birthday = DateTime.parse(birthdayStr);
  // 新建日期对象
  var date = DateTime.now();

  var ageStr =
      date.year - birthday.year > 0 ? '${date.year - birthday.year}岁' : '不到1岁';
  return ageStr;
}

showTipAlertDialog(
    BuildContext context, String title, VoidCallback confirmAction) {
  return showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text(''),
          content: Column(
            children: [
              Image.asset('assets/images/dialog-tip-icon.png'),
              const SizedBox(height: 24),
              Text(title, style: textSyle700(color: AppColors.text333))
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  titleButton('确定', () async {
                    Get.back();
                    confirmAction();
                  },
                      width: 96,
                      height: 30,
                      isCircle: true,
                      bgColor: const Color.fromRGBO(200, 227, 153, 1),
                      fontSize: 12),
                  titleButton('我在想想', () {
                    Get.back();
                  }, width: 112, height: 30, isCircle: true, fontSize: 12),
                ],
              ),
            )
          ],
          insetAnimationDuration: const Duration(seconds: 2),
        );
      });
}
