import 'package:get/get.dart';

class CreateOrderRessLogic extends GetxController {
  var tagType = 'ALL'.obs;

  void onChangeTagType (String text) => {
    tagType.value = text
  };

  List arr = [
    {
      'id': '1',
      'lineItem': [
        {
          'pic': 'assets/images/牛肉泥.png',
        },
        {
          'pic': 'assets/images/火鸡料理.png',
        },
      ],
      'orderState': {
        'orderState': 'UNPAID',
        'createdAt': '2022-06-21 12:13:34',
      },
      'orderPrice': {
        'totalPrice': '150.00',

      }
    },
    {
      'id': '2',
      'lineItem': [
        {
          'pic': 'assets/images/鸡肉料理.png',
        },
        {
          'pic': 'assets/images/猪肉便饭.png',
        },
      ],
      'orderState': {
        'orderState': 'SHIPPED',
        'createdAt': '2022-06-21 12:13:34',
      },
      'orderPrice': {
        'totalPrice': '600.00',

      }
    },
  ];
}