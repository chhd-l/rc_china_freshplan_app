import 'package:rc_china_freshplan_app/data/pet.dart';
import 'package:rc_china_freshplan_app/data/consumer.dart';
import 'package:rc_china_freshplan_app/common/util/storage.dart';

class PetUtil {
  static List<Pet> petList = [];
  static late Consumer? consumer;

  static void init() {
    consumer = StorageUtil().getJSON("loginUser") != null
        ? Consumer.fromJson(StorageUtil().getJSON("loginUser"))
        : null;
    if (consumer != null) {
      petList = StorageUtil().getJSON('${consumer?.mobile}_petList');
    }
  }

  static void addPet(Pet pet) {
    petList.add(pet);
    StorageUtil().setJSON('${consumer?.mobile}_petList', petList);
  }

  static Pet getPet(String id) {
    return petList.firstWhere((element) => element.id == id);
  }

  static void updatePet(Pet pet) {}
}
