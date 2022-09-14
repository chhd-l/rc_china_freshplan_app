import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/common/router/app_router.dart';

class OrderList extends StatelessWidget {
  const OrderList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('订单列表', selectionColor: Colors.black,),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: GestureDetector(
            child: const Icon(
              Icons.arrow_back_ios,
            ),
            onTap: () {
              Get.toNamed(AppRoutes.account);
            },
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 249, 249, 249),
          ),
          child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 30,
                ),
                child: TextField(
                maxLines: 1,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 4.0),
                  hintText: '搜索订单',
                  prefixIcon: const Icon(Icons.search),
                  // contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none),
                  filled: true,
                  fillColor: const Color(0xfafafafa),
                )
              ))
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 12),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(color: Color(0xFF96CC39), width: 2),
                      ),
                    ),
                    child: const Text(
                      '全部',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF96CC39)
                      )
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 12),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: const Text('待付款', textAlign: TextAlign.center,),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 12),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: const Text('待发货', textAlign: TextAlign.center,),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 12),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: const Text('待收货', textAlign: TextAlign.center,),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.only(top: 18, left: 12, right: 12),
              child:  ListView.builder(
                shrinkWrap: true,
                itemCount: 1,
                itemBuilder: (BuildContext ctx, int i) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 18),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0.0, 6.0), //阴影xy轴偏移量
                          blurRadius: 15.0, //阴影模糊程度
                          spreadRadius: 1.0 //阴影扩散程度
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: const [
                            Expanded(
                              child: Text('待付款', style: TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                '创建时间:2022-06-21 12:13:34', 
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Color(0xFF666666),
                                  fontSize: 12,
                                )
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 12),
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 12),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFf1f1f1),
                                  borderRadius: BorderRadius.circular(3.0),
                                ),
                                child: Image.asset(
                                  'assets/images/牛肉泥.png',
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(right: 12),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFf1f1f1),
                                  borderRadius: BorderRadius.circular(3.0),
                                ),
                                child: Image.asset(
                                  'assets/images/火鸡料理.png',
                                  width: 70,
                                  height: 70,
                                  fit: BoxFit.cover,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            children:  [
                              const Expanded(
                                child: Text('商品合计',  style: TextStyle(
                                  color: Color(0xFF666666),
                                  fontSize: 13
                                )),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    Text(
                                      '¥', 
                                      style: TextStyle(
                                        fontSize: 8,
                                        fontWeight: FontWeight.bold
                                      )
                                    ),
                                    Text(
                                      '150.00', 
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold
                                      )
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            MaterialButton(
                              shape: const RoundedRectangleBorder(
                                side: BorderSide(color: Color(0xFFCDCDCD),width: 1,style: BorderStyle.solid),
                                borderRadius: BorderRadius.all(Radius.circular(20))
                              ),
                              child: const Text('取消'),
                              onPressed: () {},
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: MaterialButton(
                                shape: const RoundedRectangleBorder(
                                  side: BorderSide.none,
                                  borderRadius: BorderRadius.all(Radius.circular(20))
                                ),
                                color: const Color.fromARGB(255, 150, 204, 57),
                                textColor: Colors.white,
                                child: const Text('付款'),
                                onPressed: () {},
                              ),
                            )
                          ]
                        )
                      ],
                    ),
                  );
                },
              )
            )
          ],
        ))
    );
  }
}
