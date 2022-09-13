import 'package:get/get.dart';

class CreatePetState {
  RxString avatar = ''.obs;
  RxString type = ''.obs;
  RxString name = ''.obs;
  RxString gender = ''.obs;
  RxString breedName = ''.obs;
  RxString birthday = ''.obs;
  RxDouble recentWeight = 0.0.obs;
  RxString recentPosture = ''.obs;
  RxDouble targetWeight = 0.0.obs;
  Rx<List<String>> recentHealth = Rx<List<String>>([]);

  RxList breedList=[].obs;
}
