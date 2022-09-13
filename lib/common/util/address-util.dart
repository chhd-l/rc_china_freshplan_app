import 'package:rc_china_freshplan_app/data/address.dart';
import 'package:rc_china_freshplan_app/data/consumer.dart';
import 'package:rc_china_freshplan_app/common/util/storage.dart';

class AddRessUtil {
  static List<AddRess> addRess = [];
  static late Consumer? consumer;

  static void init() {
    consumer = StorageUtil().getJSON("loginUser") != null
        ? Consumer.fromJson(StorageUtil().getJSON("loginUser"))
        : null;
    if (consumer != null) {
      addRess = StorageUtil().getJSON('${consumer?.addresslist}_addRess');
    }
  }

  static void addRes(AddRess pet) {
    addRess.add(pet);
    StorageUtil().setJSON('${consumer?.addresslist}_addRess', addRess);
  }

  static void updatePet(AddRess pet) {}
}
