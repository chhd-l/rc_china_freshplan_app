
import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/common/router/app_router.dart';
import 'package:rc_china_freshplan_app/data/address.dart';
import '../../common/util/addRess-util.dart';

class CreateAddRessLogic extends GetxController {

  var id = 0.obs;
  var receiverName = ''.obs;
  var phone = ''.obs;
  var province = ''.obs;
  var city = ''.obs;
  var region = ''.obs;
  var detail = ''.obs;
  var isDefault = false.obs;

  void initData(AddRess address) {
    id.value = address.id!;
    receiverName.value = address.receiverName!;
    phone.value = address.phone!;
    province.value = address.province!;
    city.value = address.city!;
    region.value = address.region!;
    detail.value = address.detail!;
    isDefault.value = address.isDefault!;
  }

  void onChangeID (int text) => {
    id.value = text
  };

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

  void recommendedRecipes(updid) {
    AddRess addRess = AddRess(
      receiverName: receiverName.value,
      id: updid != -1 ? updid : id.value,
      phone: phone.value,
      province: province.value,
      city: city.value,
      region: region.value,
      detail: detail.value,
      isDefault: isDefault.value,
    );
    id.value = id.value + 1;
    updid != -1 ? AddRessUtil.updateAddRess(addRess) : AddRessUtil.addRes(addRess);
    Get.toNamed(AppRoutes.addressManage);
  }

}