import 'dart:convert';

import 'package:intl/intl.dart';

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
