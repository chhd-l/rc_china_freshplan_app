import 'dart:convert';

handlePrice(value, {isDiscount = false}) {
  return isDiscount ? '-￥$value.00' : '￥$value.00';
}

handleDateTimeToZone(DateTime time) {
  return '${time.toIso8601String().split('.')[0]}.000Z';
}

getAgeYear(birthdayStr) {
  if (birthdayStr == '' || birthdayStr == null) {
    return '';
  }
  var birthday = json.decode(birthdayStr.split('-').toString());
  // 新建日期对象
  var date = DateTime.now();

  var ageStr =
      date.year - birthday[0] > 0 ? '${date.year - birthday[0]}岁' : '不到1岁';
  return ageStr;
}
