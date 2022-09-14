import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/common/widgets/factor.dart';
import 'logic.dart';
import 'package:rc_china_freshplan_app/common/router/app_router.dart';

class NewAddress extends StatelessWidget {
  const NewAddress({Key? key}) : super(key: key);

  @override

  Widget build(BuildContext context) {
    final CreateAddRessLogic logic = Get.put(CreateAddRessLogic());
    var args = Get.arguments;

    TextEditingController contNameroller = TextEditingController();
  
    TextEditingController contPhoneroller = TextEditingController();
  
    TextEditingController contCityroller = TextEditingController();

    TextEditingController contDateliroller = TextEditingController();
    
    WidgetsBinding.instance.addPostFrameCallback((_){
      logic.initData(args);
      contNameroller.text = logic.receiverName.value;
      contPhoneroller.text = logic.phone.value;
      contCityroller.text = logic.province.value;
      contDateliroller.text = logic.detail.value;
    });

    return Scaffold(
        appBar: AppBar(
          title: Text("${args != '-1' ? '修改' : '新增'}地址", selectionColor: Colors.black,),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: GestureDetector(
            child: const Icon(
              Icons.arrow_back_ios,
            ),
            onTap: () {
              Get.toNamed(AppRoutes.addressManage);
            },
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(12),
          color:const Color.fromARGB(255, 249, 249, 249),
          child: ListView.builder(
          shrinkWrap: true,
          itemCount: 1,
          itemBuilder: (BuildContext ctx, int i) {
            return Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(2.5, 2.5),
                        color: Color.fromRGBO(191, 191, 191, 0.1),
                        blurRadius: 2.0,
                        blurStyle: BlurStyle.solid,
                        spreadRadius: 0.0)
                  ]),
                child: Column(children: [
                Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(children: [
                  const Expanded(child: Text('收货人')),
                  Expanded(flex: 3,child: TextField(
                    controller: contNameroller,
                    onChanged: ((value) => {
                      logic.onChangeName(value)
                    }),
                    decoration: const InputDecoration(
                      hintText: '请输入姓名',
                      hintStyle: TextStyle(
                        fontSize: 13
                        ),
                      border: InputBorder.none
                        )
                      ),
                    )
                  ])
                ),
                Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(children: [
                  const Expanded(child: Text('联系电话')),
                  Expanded(flex: 3,child: TextField(
                    controller: contPhoneroller,
                    onChanged: ((value) => {
                      logic.onChangephone(value)
                    }),
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      hintText: '请输入联系电话',
                      hintStyle: TextStyle(
                        fontSize: 13
                        ),
                      border: InputBorder.none
                        )
                      ),
                    )
                  ])
                ),
                Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(children: [
                  const Expanded(child: Text('所在地区')),
                  Expanded(flex: 3,child: TextField(
                    controller: contCityroller,
                    onChanged: ((value) => {
                      logic.onChangeprovince(value)
                    }),
                    decoration: const InputDecoration(
                      hintText: '省，市，区',
                      hintStyle: TextStyle(
                        fontSize: 13
                        ),
                      border: InputBorder.none
                        )
                      ),
                    )
                  ])
                ),
                Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                  const Expanded(child: Text('详细地址')),
                  Expanded(flex: 3,child: TextField(
                    controller: contDateliroller,
                    onChanged: ((value) => {
                      logic.onChangedetail(value)
                    }),
                    decoration: const InputDecoration(
                      hintText: '请输入详细地址',
                      hintStyle: TextStyle(
                        fontSize: 13
                        ),
                      border: InputBorder.none
                        )
                      ),
                    )
                  ])
                ),
                Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    const Text('默认地址'),
                    Obx(() => CupertinoSwitch(
                      value: logic.isDefault.value, 
                      onChanged: (value){
                        logic.onChangeisDefault(value);
                      }
                    ))
                  ])
                ),
              ])
            );
          }),
        ),
        bottomNavigationBar:  Container(
            padding: const EdgeInsets.only(bottom:12.0),
            decoration: const BoxDecoration(
                color: Colors.white,
            ),
            child: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, top: 12),
            child: titleButton('保存', () {
              logic.recommendedRecipes(args);
            },
                isCircle: true,
                fontSize: 18,
                height: 38
          ),
        ),                      
      )  
    );
  }
}