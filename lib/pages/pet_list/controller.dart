import "package:get/get.dart";
import "package:rc_china_freshplan_app/data/pet.dart";
import "package:rc_china_freshplan_app/common/util/pet-util.dart";

class PetListController extends GetxController {
  List<Pet> petList = [];

  @override
  void onInit() {
    getPetList();
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
