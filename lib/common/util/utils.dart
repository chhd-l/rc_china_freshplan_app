handlePrice(value, {isDiscount = false}) {
  return isDiscount ? '-￥$value.00' : '￥$value.00';
}

handleDateTimeToZone(DateTime time){
  return '${time.toIso8601String().split('.')[0]}.000Z';
}