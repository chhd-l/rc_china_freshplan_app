import 'package:rc_china_freshplan_app/common/util/http.dart';
import 'package:rc_china_freshplan_app/common/util/pet-util.dart';
import 'package:rc_china_freshplan_app/common/values/api_path.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:rc_china_freshplan_app/common/util/storage.dart';
import 'package:rc_china_freshplan_app/api/consumer/index.dart';
import 'package:rc_china_freshplan_app/data/pet.dart';
import 'query.dart';
import 'dart:convert';

class PetEndPoint {
  static Future<List<Pet>> getPetList() async {
    String consumerId = ConsumerEndPoint.getLoggedConsumerId();
    EasyLoading.show();
    return await HttpUtil().post(petCommonUrl, params: {
      "query": getPetListQuery,
      "variables": {
        "consumerId": consumerId,
      }
    }).then((value) {
      EasyLoading.dismiss();
      var db = json.decode(value.toString())?['data']?['consumerPetFind'];
      if (db != null) {
        return List<Pet>.from(
            List.from(db).map((e) => PetUtil.normalizeFromApi(e)));
      } else {
        return [];
      }
    });
  }

  static Future createPet(Pet pet) async {
    EasyLoading.show();
    return await HttpUtil().post(petUrl, params: {
      "query": createPetMutation,
      "variables": {
        "input": PetUtil.normalizeToApi(pet),
      },
    }).then((value) {
      EasyLoading.dismiss();
      var db = json.decode(value.toString())?['data']?['consumerPetCreate'];
      if (db != null) {
        return db['id'];
      } else {
        return false;
      }
    });
  }

  static Future<bool> updatePet(Pet pet) async {
    EasyLoading.show();
    return await HttpUtil().post(petUrl, params: {
      "query": updatePetMutation,
      "variables": {
        "input": PetUtil.normalizeToApi(pet, needId: true),
      },
    }).then((value) {
      EasyLoading.dismiss();
      var db = json.decode(value.toString())?['data']?['consumerPetUpdate'];
      return db ?? false;
    });
  }

  static Future<bool> deletePet(String petId) async {
    EasyLoading.show();
    return await HttpUtil().post(petUrl, params: {
      "query": deletePetMutation,
      "variables": {
        "id": petId,
      }
    }).then((value) {
      EasyLoading.dismiss();
      var db = json.decode(value.toString())?['data']?['consumerPetDelete'];
      return db ?? false;
    });
  }
}
