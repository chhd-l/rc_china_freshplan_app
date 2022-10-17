import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/api/order/index.dart';
import 'package:rc_china_freshplan_app/common/util/order_util.dart';
import 'package:rc_china_freshplan_app/common/util/pet-util.dart';
import 'package:rc_china_freshplan_app/common/util/storage.dart';
import 'package:rc_china_freshplan_app/data/consumer.dart';
import 'package:rc_china_freshplan_app/data/pet.dart';

class AccountController extends GetxController {
  List<Pet> petList = [];
  RxInt allOrderQuantity = 0.obs;
  RxInt unpaidOrderQuantity = 0.obs;
  RxInt toShipOrderQuantity = 0.obs;
  RxInt shippedOrderQuantity = 0.obs;

  void onInit(){
    Consumer? consumer = StorageUtil().getJSON("loginUser") != null
        ? Consumer.fromJson(StorageUtil().getJSON("loginUser"))
        : null;
    if (consumer != null) {
      getPetList();
      getOrderStatistics();
    }
    super.onInit();
  }

  void getPetList() {
    PetUtil.getPetList().then((value) {
      petList.clear();
      petList.addAll(value);
      update();
    });
  }

  void getOrderStatistics() async {
    OrderUtil.getOrderStatistics().then((value) {
      allOrderQuantity.value = value["AllOrderQuantity"] ?? 0;
      unpaidOrderQuantity.value = value["UnpaidOrderQuantity"];
      toShipOrderQuantity.value = value["ToShipOrderQuantity"];
      shippedOrderQuantity.value = value["ShippedOrderQuantity"];
    });
  }

}
