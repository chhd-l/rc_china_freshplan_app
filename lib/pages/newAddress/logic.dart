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

class CreateAddRessLogic extends GetxController {

  var receiverName = ''.obs;
  var phone = ''.obs;
  var province = ''.obs;
  var city = ''.obs;
  var region = ''.obs;
  var detail = ''.obs;
  var isDefault = false.obs;

  void onChangeName (String text) => {
    receiverName.value = text
  };

  void onChangephone (String text) => {
    phone.value = text
  };

  void onChangeprovince (String text) => {
    province.value = text
  };

  void onChangedetail (String text) => {
    detail.value = text
  };

  void onChangeisDefault (bool text) => {
    isDefault.value = text
  };

}