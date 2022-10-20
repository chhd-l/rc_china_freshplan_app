import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/common/router/app_router.dart';
import 'package:rc_china_freshplan_app/common/util/pet_util.dart';
import 'package:rc_china_freshplan_app/global.dart';

import 'state.dart';

class ChoosePetLogic extends GetxController {
  final state = ChoosePetState();

  @override
  void onInit() {
    getPetList();
    super.onInit();
  }

  void getPetList() {
    PetUtil.getPetList().then((value) {
      state.petList.value = [];
      for (var element in value) {
        if (element.subscriptionNo!.isEmpty) {
          state.petList.value.add(element);
        }
      }
      if (state.petList.value.isNotEmpty) {
        state.currentPet.value = state.petList.value[0];
      }
      update();
    });
  }

  void recommendedRecipes() async {
    Get.put(GlobalConfigService()).checkoutPet.value = state.currentPet.value;
    Get.toNamed(AppRoutes.recommendRecipes);
  }

  selectPet(pet) {
    state.currentPet.value = pet;
  }
}
