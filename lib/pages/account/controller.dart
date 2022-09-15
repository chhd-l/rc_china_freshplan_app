import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/common/util/pet-util.dart';
import 'package:rc_china_freshplan_app/data/pet.dart';

class AccountController extends GetxController {
  List<Pet> petList = [];

  void getPetList() {
    PetUtil.getPetList().then((value) {
      petList.clear();
      petList.addAll(value);
      update();
    });
  }
}
