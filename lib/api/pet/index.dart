import 'package:image_picker/image_picker.dart';
import 'package:rc_china_freshplan_app/common/util/http.dart';
import 'package:rc_china_freshplan_app/common/util/pet_util.dart';
import 'package:rc_china_freshplan_app/common/values/api_path.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:rc_china_freshplan_app/api/consumer/index.dart';
import 'package:rc_china_freshplan_app/data/pet.dart';
import 'query.dart';
import 'dart:convert';
import 'package:dio/src/multipart_file.dart' as DIOMUL;
import 'package:dio/src/form_data.dart' as DIOFORM;

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

  static Future uploadImage(XFile image) async {
    String path = image.path;
    var name = path.substring(path.lastIndexOf("/") + 1, path.length);
    DIOFORM.FormData formdata = DIOFORM.FormData.fromMap(
        {"file": await DIOMUL.MultipartFile.fromFile(path, filename: name)});

    EasyLoading.show();
    return await HttpUtil()
        .post(upload, params: formdata)
        .onError((ErrorEntity error, stackTrace) {
      EasyLoading.showError(error.message!);
    }).then((value) {
      EasyLoading.dismiss();
      if (value == null) return;
      print(value);
      var result = json.decode(value.toString())["url"];
      return result ?? '';
    });
  }
}
