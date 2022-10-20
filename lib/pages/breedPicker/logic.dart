import 'package:azlistview/azlistview.dart';
import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/data/pet_breed.dart';
import 'package:rc_china_freshplan_app/global.dart';
import 'package:lpinyin/lpinyin.dart';

class BreedPickerLogic extends GetxController {
  List<PetBreed> breedList = [];

  final callback = Get.arguments == null ? null : Get.arguments['callback'];

  @override
  void onInit() {
    super.onInit();
    final petType = Get.arguments == null ? null : Get.arguments['petType'];
    final initList = petType == 'CAT'
        ? Get.put(GlobalConfigService()).catBreedList
        : Get.put(GlobalConfigService()).dogBreedList;
    for (var element in initList) {
      breedList.add(PetBreed.fromJson(element));
    }
    handleList(breedList);
  }

  handleList(List<PetBreed> list) {
    if (list.isEmpty) return [];
    for (int i = 0, length = list.length; i < length; i++) {
      String pinyin = PinyinHelper.getPinyinE(list[i].name ?? '');
      String tag = pinyin.substring(0, 1).toUpperCase();
      list[i].namePinyin = pinyin;
      if (RegExp("[A-Z]").hasMatch(tag)) {
        list[i].tagIndex = tag;
      } else {
        list[i].tagIndex = "#";
      }
    }
    SuspensionUtil.sortListBySuspensionTag(list);
    SuspensionUtil.setShowSuspensionStatus(list);
  }

  selectBreed(PetBreed breed) {
    callback(breed.name, breed.code);
    Get.back();
  }
}
