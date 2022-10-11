import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/common/values/colors.dart';
import 'package:rc_china_freshplan_app/common/widgets/factor.dart';
import 'logic.dart';

class NewAddress extends StatelessWidget {
  const NewAddress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CreateAddressLogic logic = Get.put(CreateAddressLogic());
    var args = Get.arguments;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      logic.initData(args);
    });

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "${args != '-1' ? '修改' : '新增'}地址",
            style: textSyle700(fontSize: 18),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: GestureDetector(
            child: const Icon(
              Icons.arrow_back_ios,
            ),
            onTap: () {
              Get.back();
            },
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 249, 249, 249),
        body: Column(
          children: [
            Container(
                margin: const EdgeInsets.only(top: 15, right: 12, left: 12),
                padding: const EdgeInsets.only(top: 10, right: 15, left: 15),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(2.5, 2.5),
                          color: Color.fromRGBO(191, 191, 191, 0.1),
                          blurRadius: 2.0,
                          blurStyle: BlurStyle.solid,
                          spreadRadius: 0.0)
                    ]),
                child: Column(children: [
                  Row(children: [
                    Expanded(
                        child: Text('收货人', style: textSyle700(fontSize: 15))),
                    Expanded(
                      flex: 3,
                      child: TextField(
                          controller: logic.contNameroller,
                          onChanged: ((value) => {logic.onChangeName(value)}),
                          decoration: const InputDecoration(
                              hintText: '请输入姓名',
                              hintStyle: TextStyle(
                                  fontSize: 13,
                                  color: Color.fromARGB(255, 202, 202, 202)),
                              border: InputBorder.none)),
                    )
                  ]),
                  const Divider(color: Color.fromARGB(255, 231, 231, 231)),
                  Row(children: [
                    Expanded(
                        child: Text(
                      '联系电话',
                      style: textSyle700(fontSize: 15),
                    )),
                    Expanded(
                      flex: 3,
                      child: TextField(
                          controller: logic.contPhoneroller,
                          onChanged: ((value) => {logic.onChangephone(value)}),
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                              hintText: '请输入联系电话',
                              hintStyle: TextStyle(
                                  fontSize: 13,
                                  color: Color.fromARGB(255, 202, 202, 202)),
                              border: InputBorder.none)),
                    )
                  ]),
                  const Divider(color: Color.fromARGB(255, 231, 231, 231)),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Row(children: [
                      Expanded(
                          child:
                              Text('所在地区', style: textSyle700(fontSize: 15))),
                      Expanded(
                        flex: 3,
                        child: GestureDetector(
                          onTap: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            logic.cityPicker(context);
                          },
                          child: Obx(() => Text(
                              logic.province.value != ''
                                  ? '${logic.province.value}，${logic.city.value}，${logic.region.value}'
                                  : '省，市，区',
                              style: textSyle700(
                                  fontSize: 13,
                                  color: logic.province.value != ''
                                      ? AppColors.primaryText
                                      : const Color.fromARGB(
                                          255, 202, 202, 202)))),
                        ),
                      )
                    ]),
                  ),
                  const Divider(color: Color.fromARGB(255, 231, 231, 231)),
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text('详细地址', style: textSyle700(fontSize: 15)),
                    )),
                    Expanded(
                      flex: 3,
                      child: TextField(
                          controller: logic.contDateliroller,
                          onChanged: ((value) => {logic.onChangedetail(value)}),
                          maxLines: 3,
                          decoration: const InputDecoration(
                              hintText: '请输入详细地址',
                              hintStyle: TextStyle(
                                  fontSize: 13,
                                  color: Color.fromARGB(255, 202, 202, 202)),
                              border: InputBorder.none)),
                    )
                  ]),
                ])),
            Container(
                margin: const EdgeInsets.only(top: 15, right: 12, left: 12),
                padding: const EdgeInsets.only(
                    top: 12, right: 15, left: 15, bottom: 12),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(2.5, 2.5),
                          color: Color.fromRGBO(191, 191, 191, 0.1),
                          blurRadius: 2.0,
                          blurStyle: BlurStyle.solid,
                          spreadRadius: 0.0)
                    ]),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('默认地址', style: textSyle700(fontSize: 15)),
                      Obx(() => CupertinoSwitch(
                          activeColor: AppColors.tint,
                          value: logic.isDefault.value,
                          onChanged: (value) {
                            logic.onChangeisDefault(value);
                          }))
                    ])),
          ],
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.only(bottom: 12.0),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 48, right: 48, top: 12),
            child: titleButton('保存', () {
              logic.recommendedRecipes(args);
            }, isCircle: true, fontSize: 18, height: 46),
          ),
        ));
  }
}
