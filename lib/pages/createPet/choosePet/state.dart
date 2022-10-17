import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/data/pet.dart';

class ChoosePetState {
  Rx<List<Pet>> petList = Rx<List<Pet>>([]);
  Rx<Pet> currentPet = Rx<Pet>(Pet());
}
