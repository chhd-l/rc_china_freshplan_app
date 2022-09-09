import 'package:flutter/material.dart';
import 'package:rc_china_freshplan_app/common/widgets/factor.dart';
import 'package:rc_china_freshplan_app/pages/newAddress/view.dart';
/// This Widget is the main application widget.
const ress = 'xxxx';
class AddRessManage extends StatelessWidget {

  const AddRessManage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: commonAppBar('地址管理'),
        body: const Center(
          child: MyStatefulWidget(key: null,),
        ),
        bottomNavigationBar:  Container(
            padding: const EdgeInsets.only(bottom:12.0),
            decoration: const BoxDecoration(
                color: Colors.white,
            ),
            child: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, top: 12),
            child: titleButton('新增地址', () {
                    Navigator.push(context, 
                      MaterialPageRoute(
                        builder: (BuildContext ress) {
                          return const NewAddress(
                              name: '',
                              details: '',
                              open: false,
                              phone:'',
                              cite: '',
                            );
                        }),
                    );
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
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

List ressList = [false, true];

class _MyStatefulWidgetState extends State<MyStatefulWidget> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  const Color.fromARGB(255, 249, 249, 249),
      body:  ListView.builder(
          shrinkWrap: true,
          itemCount: ressList.length,
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
              margin: const EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0),
              padding: const EdgeInsets.all(12.0),
              child: Column(
              children:  [
                Row(
                  children: const [
                    Expanded( 
                      child: Text('我的', style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              )),
                    ),
                    Expanded(
                      child: Text('18723489954', textAlign: TextAlign.right, style: TextStyle(
                               color: Color.fromARGB(255, 153, 153, 153),
                             ),),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                  child: const Text('重庆市 重庆市 沙坪坝区 重庆市沙坪坝区 重庆某某某街道学')
                ),
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
                              value: ressList[i],
                              groupValue: true,
                              onChanged: (value) {
                                setState(() {
                                  ressList.reversed;
                                });
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
                              Navigator.push(context, 
                                MaterialPageRoute(
                                  builder: (BuildContext ress) {
                                    return NewAddress(
                                        name: '我的',
                                        details: '重庆市沙坪坝区 重庆某某某街道学',
                                        open: ressList[i],
                                        phone:'18723489954',
                                        cite: '重庆市 重庆市 沙坪坝区',
                                      );
                                  }),
                              );
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
            );
          },
        ),
    );
  }
}
