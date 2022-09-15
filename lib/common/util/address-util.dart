import 'package:rc_china_freshplan_app/data/address.dart';
import 'package:rc_china_freshplan_app/data/consumer.dart';
import 'package:rc_china_freshplan_app/common/util/storage.dart';

class AddRessUtil {
  static List<AddRess> addRessList = [];
  static late Consumer? consumer;

  static Future<void> init() async {
    consumer = StorageUtil().getJSON("loginUser") != null
        ? Consumer.fromJson(StorageUtil().getJSON("loginUser"))
        : null;
    if (consumer != null) {
      var petListInStorage =
          StorageUtil().getJSON('${consumer?.addresslist}_addRess');
      if (petListInStorage != null) {
        List<dynamic> list = List.from(petListInStorage);
        addRessList = List<AddRess>.from(list.map((e) => AddRess.fromJson(e)));
      }
    }
  }

  static void logout() {
    addRessList.clear();
  }

  static void addRes(AddRess pet) {
    print('2222222');
    addRessList.add(pet);
    print(addRessList.length);
    StorageUtil().setJSON('${consumer?.addresslist}_addRess', addRessList);
  }

  static AddRess getAddRess(String id) {
    var init = addRessList.singleWhere((element) => element.id == id,
        orElse: () => AddRess(
              id: '-1',
              receiverName: '',
              phone: '',
              region: '',
              city: '',
              detail: '',
              isDefault: false,
              province: '',
            ));
    return init;
  }

  static void updateAddRess(AddRess pet) {
    int idx = 0;
    addRessList.asMap().entries.forEach((element) {
      if (element.value.id == pet.id) {
        idx = element.key;
      }
    });
    addRessList.replaceRange(idx, idx + 1, [pet]);
    StorageUtil().setJSON('${consumer?.phone}_addRess', addRessList);
  }

  static void removeAddRess(AddRess pet) {
    int idx = 0;
    addRessList.asMap().entries.forEach((element) {
      if (element.value.id == pet.id) {
        idx = element.key;
      }
    });
    addRessList.replaceRange(idx, idx + 1, []);
    StorageUtil().setJSON('${consumer?.phone}_addRess', addRessList);
  }

  static void removeAllAddRess() {
    addRessList.clear();
    StorageUtil().remove('${consumer?.phone}_addRess');
  }
}
