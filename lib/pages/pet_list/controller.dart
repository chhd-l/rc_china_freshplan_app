import "package:get/get.dart";
import 'package:rc_china_freshplan_app/common/util/event_bus.dart';
import 'package:rc_china_freshplan_app/common/values/const.dart';
import "package:rc_china_freshplan_app/data/pet.dart";
import "package:rc_china_freshplan_app/common/util/pet_util.dart";

class PetListController extends GetxController {
  List<Pet> petList = [];

  @override
  void onInit() {
    getPetList();
    EventBus().addListener(updatePet, (arg) {
      getPetList();
    });
    super.onInit();
  }

  void getPetList() {
    PetUtil.getPetList().then((value) {
      petList.clear();
      petList.addAll(value);
      update();
    });
  }
}
