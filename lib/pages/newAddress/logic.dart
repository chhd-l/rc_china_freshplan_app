import 'package:get/get.dart';

// class CreateRessState {
//   RxString receiverName = ''.obs;
//   RxString phone=''.obs;
//   RxString province=''.obs;
//   RxString city=''.obs;
//   RxString region=''.obs;
//   RxString detail=''.obs;
//   RxBool isDefault=false.obs;
// }

class CreatePetLogic extends GetxController {

  var ress = {
    'receiverName': '',
    'phone': '',
    'province': '',
    'city': '',
    'region': '',
    'detail': '',
    'isDefault': false,
  };

  void onRess(val) {
    ress = val;
  }
}