import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/global.dart';

class CheckoutLogic extends GetxController {
  RxList orderProduct = [].obs;
  final global = Get.put(GlobalConfigService());

  RxInt productTotalPrice = 129.obs; //商品总价

  int discountPrice = 20; //促销折扣
  int newDiscountPrice = 20; //新人折扣
  int deliveryPrice = 0; //运费

  final List recipesList = [
    {
      'name': '牛肉泥',
      'description': '牛肉、土豆、鸡蛋、胡萝卜、豌豆',
      'assets': 'assets/images/牛肉泥.png',
      "value": 0,
      "price": 129.00
    },
    {
      'name': '火鸡料理',
      'description': '火鸡、糙米、鸡蛋、胡萝卜、菠菜',
      'assets': 'assets/images/火鸡料理.png',
      "value": 1,
      "price": 129.00
    },
    {
      'name': '鸡肉料理',
      'description': '鸡肉、红薯、南瓜、菠菜',
      'assets': 'assets/images/鸡肉料理.png',
      "value": 2,
      "price": 129.00
    },
    {
      'name': '猪肉便饭',
      'description': '猪肉、土豆、青豆、南瓜、羽衣甘蓝、蘑菇',
      'assets': 'assets/images/猪肉便饭.png',
      "value": 3,
      "price": 129.00
    },
  ];

  @override
  void onReady() {
    for (var element in recipesList) {
      setOrderProduct(element);
    }
    print(global.selectProduct);
    print(orderProduct);
    super.onReady();
  }

  setOrderProduct(element) {
    if (global.selectProduct.contains(element['value'])) {
      orderProduct.insert(0, element);
    }
  }

  //支付总价
  payTotalPrice() {
    return productTotalPrice - discountPrice - newDiscountPrice - deliveryPrice;
  }

  handlePrice(value, {isDiscount = false}) {
    return isDiscount ? '-￥$value.00' : '￥$value.00';
  }
}
