import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/common/router/app_router.dart';
import './logic.dart';

class OrderList extends StatelessWidget {
  const OrderList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

  returnType (String type) {
    if (type == 'UNPAID') {
      return '待付款';
    } else if (type == 'TO_SHIP') {
      return '待发货';
    } else if (type == 'SHIPPED') {
      return '待收货';
    } else {
      return 'xx';
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
  
  final CreateOrderRessLogic logic = Get.put(CreateOrderRessLogic());
  var orderLists = logic.arr;

  Widget bodySection = Container(
      padding: const EdgeInsets.only(top: 18, left: 12, right: 12),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: orderLists.length,
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
                      child: Text(returnType(orderLists[i]['orderState']['orderState']), style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        '创建时间:${orderLists[i]['orderState']['createdAt']}', 
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
                    itemCount: orderLists[i]['lineItem'].length,
                    itemExtent: 70,
                    cacheExtent: 160,
                    itemBuilder: (BuildContext ctxs, int index) {
                      return Container(
                        margin: const EdgeInsets.only(right: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFf1f1f1),
                          borderRadius: BorderRadius.circular(3.0),
                        ),
                        child: Image.asset(
                          orderLists[i]['lineItem'][index]['pic'],
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
                              orderLists[i]['orderPrice']['totalPrice'], 
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
                      child: Text(returnCancelText(orderLists[i]['orderState']['orderState'])),
                      onPressed: () {},
                    ),
                    ClipOval(
                      child: (orderLists[i]['orderState']['orderState'] == 'UNPAID' 
                    || orderLists[i]['orderState']['orderState'] == 'SHIPPED')
                    ? Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: MaterialButton(
                          shape: const RoundedRectangleBorder(
                            side: BorderSide(color: Color(0xFF96CC39),width: 1,style: BorderStyle.solid),
                            borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                          textColor: const Color(0xFF96CC39),
                          child: Text(returnDetermine(orderLists[i]['orderState']['orderState'])),
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
    );
  
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
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(bottom: 3),
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
            Text('xxxx')
          ],
        ))
      )
    );
  }
}
