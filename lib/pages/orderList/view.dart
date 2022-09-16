import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/common/router/app_router.dart';
import 'package:rc_china_freshplan_app/common/util/order_util.dart';
import 'package:rc_china_freshplan_app/data/order.dart';
import 'logic.dart';

class OrderList extends StatefulWidget {
  const OrderList({Key? key}) : super(key: key);

  @override
  _OrderListWidgetState createState() => _OrderListWidgetState();
}

class _OrderListWidgetState extends State<OrderList> {
  final OrderLogic logic = Get.put(OrderLogic());
  Widget build(BuildContext context) {
  logic.getOrderList();
  var orders = OrderUtil.orderLists;

  returnType (String type) {
    if (type == 'UNPAID') {
      return '待付款';
    } else if (type == 'TO_SHIP') {
      return '待发货';
    } else if (type == 'SHIPPED') {
      return '待收货';
    } else if (type == 'COMPLETED') {
      return '交易成功';
    } else {
      return '交易关闭';
    }
  }

  returnCancelText (String type) {
    if (type == 'UNPAID') {
      return '取消';
    } else if (type == 'TO_SHIP') {
      return '催发货';
    } else if (type == 'VOID') {
      return '删除订单';
    } else {
      return '查看物流';
    }
  }

  returnDetermine (String type) {
    if (type == 'UNPAID') {
      return '付款';
    } else {
      return '确认收货';
    }
  }
  
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
        body: SingleChildScrollView(
          child: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 249, 249, 249),
          ),
          child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 12, left: 12, right: 12, bottom: 15),
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
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none),
                  filled: true,
                  fillColor: const Color(0xfafafafa),
                )
              ))
            ),
            Obx(() => Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: (() {
                      logic.onChangeTagType('ALL');
                      logic.getOrderList();
                      setState(() {
                        orders = logic.orderLists;
                      });
                    }),
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: logic.tagType.value == 'ALL' ? const BorderSide(color: Color(0xFF96CC39), width: 2) : BorderSide.none,
                        ),
                      ),
                      child: Text(
                        '全部',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: logic.tagType.value == 'ALL' ? const Color(0xFF96CC39) : Colors.black,
                          fontWeight: logic.tagType.value == 'ALL' ? FontWeight.bold : FontWeight.normal,
                          fontSize: 15
                        )
                      ),
                    ),
                  )
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: (() {
                      logic.onChangeTagType('UNPAID');
                      logic.getOrderList();
                      setState(() {
                        orders = logic.orderLists;
                      });
                    }),
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: logic.tagType.value == 'UNPAID' ? const BorderSide(color: Color(0xFF96CC39), width: 2) : BorderSide.none,
                        ),
                      ),
                      child: Text(
                        '待付款', 
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: logic.tagType.value == 'UNPAID' ? const Color(0xFF96CC39) : Colors.black,
                          fontWeight: logic.tagType.value == 'UNPAID' ? FontWeight.bold : FontWeight.normal,
                          fontSize: 15
                        )
                      ),
                    ),
                  )
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: (() {
                      logic.onChangeTagType('TO_SHIP');
                      logic.getOrderList();
                      setState(() {
                        orders = logic.orderLists;
                      });
                    }),
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: logic.tagType.value == 'TO_SHIP' ? const BorderSide(color: Color(0xFF96CC39), width: 2) : BorderSide.none,
                        ),
                      ),
                      child: Text(
                        '待发货', 
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: logic.tagType.value == 'TO_SHIP' ? const Color(0xFF96CC39) : Colors.black,
                          fontWeight: logic.tagType.value == 'TO_SHIP' ? FontWeight.bold : FontWeight.normal,
                          fontSize: 15
                        )
                      ),
                    ),
                  )
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: (() {
                      logic.onChangeTagType('SHIPPED');
                      logic.getOrderList();
                      setState(() {
                        orders = logic.orderLists;
                      });
                    }),
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: logic.tagType.value == 'SHIPPED' ? const BorderSide(color: Color(0xFF96CC39), width: 2) : BorderSide.none,
                        ),
                      ),
                      child: Text('待收货',
                      textAlign: TextAlign.center,
                        style: TextStyle(
                          color: logic.tagType.value == 'SHIPPED' ? const Color(0xFF96CC39) : Colors.black,
                          fontWeight: logic.tagType.value == 'SHIPPED' ? FontWeight.bold : FontWeight.normal,
                          fontSize: 15
                        )
                      ),
                    ),
                  )
                ),
              ],
            )),
            Container(
              child: orders.length == '0' ? Container(
                margin: const EdgeInsets.only(top: 38),
                child: Column(
                  children: [
                    Image.network(
                      'https://dtcdata.oss-cn-shanghai.aliyuncs.com/asset/image/image 43.png',
                      width: 158,
                      height: 158,
                      fit: BoxFit.cover,
                    ),
                    const Text('啥也没有~', style: TextStyle(
                            color: Color(0xFF666666),
                          )),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      width: 156,
                      height: 36,
                      child: MaterialButton(
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(color: Color(0xFF96CC39),width: 1,style: BorderStyle.solid),
                          borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        textColor: const Color(0xFF96CC39),
                        child: const Text('开始定制'),
                        onPressed: () async {
                          // Get.toNamed(AppRoutes.petList);
                        },
                      ),
                    )
                  ],
                ),
              ) : Container(
                padding: const EdgeInsets.only(top: 18, left: 12, right: 12),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: orders.length,
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
                            children: [
                              Expanded(
                                child: Text(returnType(orders[i]['orderState']['orderState']), style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                )),
                              ),
                              Expanded(
                                flex: 3,
                                child: Text(
                                  '创建时间:${orders[i]['orderState']['createdAt']}', 
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                    color: Color(0xFF666666),
                                    fontSize: 12,
                                  )
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 12),
                            height: 70,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: orders[i]['lineItem'].length,
                              itemExtent: 70,
                              cacheExtent: 160,
                              itemBuilder: (BuildContext ctxs, int index) {
                                List item = orders[i]['lineItem'];
                                return Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFf1f1f1),
                                    borderRadius: BorderRadius.circular(3.0),
                                  ),
                                  child: Image.network(
                                    item[index]['pic'] as String,
                                    width: 70,
                                    height: 70,
                                    fit: BoxFit.cover,
                                  ),
                                );
                              }
                            )
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
                                    children: [
                                      const Text(
                                        '¥', 
                                        style: TextStyle(
                                          fontSize: 8,
                                          fontWeight: FontWeight.bold
                                        )
                                      ),
                                      Text(
                                        '${orders[i]['orderPrice']['totalPrice']}.00', 
                                        style: const TextStyle(
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
                                child: Text(returnCancelText(orders[i]['orderState']['orderState'])),
                                onPressed: () async {},
                              ),
                              Container(
                                child: (orders[i]['orderState']['orderState'] == 'UNPAID' 
                              || orders[i]['orderState']['orderState'] == 'SHIPPED')
                              ? Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  child: MaterialButton(
                                    shape: const RoundedRectangleBorder(
                                      side: BorderSide(color: Color(0xFF96CC39),width: 1,style: BorderStyle.solid),
                                      borderRadius: BorderRadius.all(Radius.circular(20))
                                    ),
                                    textColor: const Color(0xFF96CC39),
                                    child: Text(returnDetermine(orders[i]['orderState']['orderState'])),
                                    onPressed: () {},
                                  ),
                                ) : null,
                              )
                            ]
                          )
                        ],
                      ),
                    );
                  },
                )
              )
            )
          ],
        ))
      )
    );
  }
}
