import 'package:flutter/material.dart';
import 'package:rc_china_freshplan_app/common/widgets/factor.dart';
import 'package:rc_china_freshplan_app/common/util/storage.dart';
import 'package:rc_china_freshplan_app/data/consumer.dart';
import 'package:rc_china_freshplan_app/common/util/addRess-util.dart';
import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/common/router/app_router.dart';

class AddRessManage extends StatelessWidget {
  var isFromCheckout = false;
  AddRessManage({super.key}) {
    isFromCheckout = Get.arguments ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: commonAppBar('地址管理'),
        body: MyStatefulWidget(isFromCheckout),
        bottomNavigationBar:  Container(
            padding: const EdgeInsets.only(bottom:12.0),
            decoration: const BoxDecoration(
                color: Colors.white,
            ),
            child: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, top: 12),
            child: titleButton('新增地址', () {
                    Get.toNamed(AppRoutes.newAddress);
                  },
                  isCircle: true,
                  fontSize: 18,
                  height: 38,
          ),
        ),                      )  
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  var isCheckout = false;
  MyStatefulWidget(bool isFromCheckout, {super.key}) {
    isCheckout = isFromCheckout;
  }

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

List ressList = [false, true];

class _MyStatefulWidgetState extends State<MyStatefulWidget> {

  @override
  Widget build(BuildContext context) {

    Consumer? consumer = StorageUtil().getJSON("loginUser") != null
        ? Consumer.fromJson(StorageUtil().getJSON("loginUser"))
        : null;
    if (consumer != null) {
      AddRessUtil.init();
    }

    var addRessList = AddRessUtil.addRessList;
    print(addRessList.length != 0 ? addRessList[0].id : 0);

    return Scaffold(
      backgroundColor:  const Color.fromARGB(255, 249, 249, 249),
      body:  ListView.builder(
          shrinkWrap: true,
          itemCount: addRessList.length,
          itemBuilder: (BuildContext ctx, int i) {
          return GestureDetector(
              onTap: () {
                if (widget.isCheckout) {
                  Get.offNamed(AppRoutes.checkout, arguments: addRessList[i]);
                }
              },
              child:Container(
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
              margin: const EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0),
              padding: const EdgeInsets.all(12.0),
              child: Column(
              children:  [
                Row(
                  children: [
                    Expanded( 
                      child: Text(addRessList[i].receiverName as String, style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              )),
                    ),
                    Expanded(
                      child: Text(addRessList[i].phone as String, textAlign: TextAlign.right, style: const TextStyle(
                               color: Color.fromARGB(255, 153, 153, 153),
                             ),),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded( 
                      child: Container(
                      margin: const EdgeInsets.only(top: 12.0, bottom: 12.0, left: 0, right: 0),
                      padding: const EdgeInsets.all(0),
                      child: Text(
                        '${addRessList[i].province as String} ${addRessList[i].city as String} ${addRessList[i].region as String} ${addRessList[i].detail as String} ', 
                        textAlign: TextAlign.left,
                      )
                    ),                
                  ),
                ]),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => {
                          
                        },
                        child: Row(
                          children: [
                            Radio(
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              value: addRessList[i].isDefault as bool,
                              groupValue: true,
                              onChanged: (value) {
                                setState(() {
                                  addRessList[i].isDefault = true;
                                });
                                print(value);
                                print(addRessList[i].isDefault);
                              },
                            ),
                            const Text('默认地址', style: TextStyle(
                              color: Color.fromARGB(255, 153, 153, 153),
                            )),
                          ] 
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoutes.newAddress, arguments: addRessList[i].id);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 8.0),
                              child: Image.asset(
                                        'assets/images/ressEdit.png',
                                        width: 27,
                                        height: 27,
                                        fit: BoxFit.fitWidth,
                                      ),
                            )
                          ),
                          GestureDetector(
                            onTap: (() {
                              AddRessUtil.removeAddRess(addRessList[i]);
                              setState(() {
                                addRessList = AddRessUtil.addRessList;
                              });
                            }),
                            child: Image.asset(
                              'assets/images/ressDelete.png',
                              width: 27,
                              height: 27,
                              fit: BoxFit.fitWidth,
                            )
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            ));
          },
        ),
    );
  }
}
