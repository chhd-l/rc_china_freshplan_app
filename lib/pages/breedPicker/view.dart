import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/common/router/app_router.dart';
import 'package:azlistview/azlistview.dart';
import 'package:lpinyin/lpinyin.dart';
import 'package:rc_china_freshplan_app/common/values/values.dart';
import 'package:rc_china_freshplan_app/data/petBreed.dart';
import 'package:rc_china_freshplan_app/global.dart';

import '../../common/widgets/factor.dart';
import 'logic.dart';

class BreedListPickerPage extends StatelessWidget {
  BreedListPickerPage({Key? key}) : super(key: key);

  final BreedPickerLogic logic = Get.put(BreedPickerLogic());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: commonAppBar('宠物品种'),
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: AzListView(
              data: logic.breedList,
              itemCount: logic.breedList.length,
              indexBarItemHeight: 20,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    logic.selectBreed(logic.breedList[index]);
                  },
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    margin: const EdgeInsets.only(left: 24, right: 48),
                    padding: const EdgeInsets.only(left: 24),
                    alignment: Alignment.centerLeft,
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Color.fromARGB(255, 231, 231, 231)))),
                    child: Text(logic.breedList[index].name ?? ''),
                  ),
                );
              },
              susItemBuilder: (BuildContext context, int index) {
                PetBreed model = logic.breedList[index];
                String tag = model.getSuspensionTag();
                return Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(left: 16.0),
                  color: const Color(0xFFF3F4F5),
                  alignment: Alignment.centerLeft,
                  child: Text(tag, style: textSyle700(fontSize: 16.0)),
                );
              },
            )),
          ],
        )));
  }
}
