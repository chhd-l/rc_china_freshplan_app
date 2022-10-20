import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/common/router/app_router.dart';
import 'package:rc_china_freshplan_app/common/util/subscription_util.dart';
import 'package:rc_china_freshplan_app/common/util/utils.dart';
import 'package:rc_china_freshplan_app/common/values/colors.dart';
import 'package:rc_china_freshplan_app/common/widgets/factor.dart';
import 'package:rc_china_freshplan_app/global.dart';

Widget planCommonBox(Widget child) {
  return Container(
    padding: const EdgeInsets.all(15),
    margin: const EdgeInsets.only(bottom: 15),
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(8)),
      boxShadow: [
        BoxShadow(
            color: Color.fromRGBO(191, 191, 191, 0.1),
            offset: Offset(0.0, 6.0), //阴影xy轴偏移量
            blurRadius: 15.0, //阴影模糊程度
            spreadRadius: 1.0 //阴影扩散程度
            )
      ],
    ),
    child: child,
  );
}

Widget planProductItem(pic, name, price, quantity) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
          width: 73,
          height: 73,
          decoration: const BoxDecoration(
              color: AppColors.baseGray,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: CachedNetworkImage(
            imageUrl: pic ?? 'assets/images/牛肉泥.png',
            placeholder: (context, url) => Image.asset('assets/images/牛肉泥.png'),
            errorWidget: (context, url, error) =>
                Image.asset('assets/images/牛肉泥.png'),
            width: 61,
            height: 61,
            fit: BoxFit.cover,
          )),
      const SizedBox(width: 10),
      Expanded(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name ?? '牛肉泥',
              style: textSyle400(fontSize: 15, color: AppColors.text333)),
          const SizedBox(height: 10),
          Text(handlePrice(price),
              style: textSyle700(fontSize: 12, color: AppColors.text999)),
        ],
      )),
      Text("X$quantity",
          style: textSyle700(fontSize: 12, color: AppColors.text999)),
    ],
  );
}

Widget buildPlanProductView(planDetail, context, price) {
  return planCommonBox(Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        planDetail["status"] == 'VOID' ? "计划商品" : "下次发货",
        style: textSyle700(fontSize: 15, color: AppColors.text222),
      ),
      const SizedBox(height: 12),
      const Divider(color: Color.fromRGBO(226, 226, 226, 1)),
      const SizedBox(height: 12),
      ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: (planDetail["productList"] ?? []).length,
          itemBuilder: (BuildContext ctx, int i) {
            var item = planDetail["productList"][i];
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: planProductItem(
                  item["variants"]["defaultImage"],
                  item["name"],
                  item["variants"]["subscriptionPrice"],
                  item["variants"]["num"]),
            );
          }),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('商品金额', style: textSyle700(color: AppColors.text666)),
          Text(handlePrice(price["productPrice"]),
              style: textSyle700(color: AppColors.text333))
        ],
      ),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('促销折扣', style: textSyle700(color: AppColors.text666)),
          Text(handlePrice(price["discountsPrice"] ?? 0),
              style: textSyle700(color: AppColors.text333))
        ],
      ),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('运费', style: textSyle700(color: AppColors.text666)),
          Text(handlePrice(price["deliveryPrice"] ?? 0),
              style: textSyle700(color: AppColors.text333))
        ],
      ),
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text('商品小计：', style: textSyle700(color: AppColors.text333)),
          Text(handlePrice(price["totalPrice"] ?? 0),
              style: textSyle700(
                  fontSize: 15, color: const Color.fromRGBO(212, 157, 40, 1)))
        ],
      ),
      planDetail["status"] != 'VOID'
          ? Column(
              children: [
                const SizedBox(height: 12),
                const Divider(color: Color.fromRGBO(226, 226, 226, 1)),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: () {
                    SubscriptionUtil.cancelSubAction(context, planDetail["id"]);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/cancel-icon.png'),
                      const SizedBox(width: 10),
                      Text(
                        '取消计划',
                        style:
                            textSyle700(fontSize: 12, color: AppColors.text999),
                      )
                    ],
                  ),
                )
              ],
            )
          : Container()
    ],
  ));
}

Widget buildDeliveryInfoView(isCancel, deliveryDate, address) {
  return planCommonBox(Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "发货信息",
        style: textSyle700(fontSize: 15, color: AppColors.text222),
      ),
      const SizedBox(height: 12),
      const Divider(color: Color.fromRGBO(226, 226, 226, 1)),
      const SizedBox(height: 12),
      !isCancel
          ? Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Image.asset('assets/images/delivery-date.png'),
                  const SizedBox(width: 10),
                  Text('发货日期', style: textSyle700(color: AppColors.text666)),
                  const SizedBox(width: 10),
                  Text(deliveryDate,
                      style: textSyle700(color: AppColors.text666))
                ],
              ),
            )
          : Container(),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Image.asset('assets/images/delivery-address.png'),
          ),
          const SizedBox(width: 10),
          Text('收货地址', style: textSyle700(color: AppColors.text666)),
          const SizedBox(width: 10),
          SizedBox(
            width: 220,
            child: Text(
              '${address["receiverName"]} ${address["phone"]}\n${address["province"]}${address["city"]}${address["region"]} ${address["detail"]}',
              style: textSyle700(color: AppColors.text666),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      !isCancel
          ? Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  titleButton('修改地址', () {
                    Get.put(GlobalConfigService())
                        .isPlanDetailSelectAddress
                        .value = true;
                    Get.toNamed(AppRoutes.addressManage);
                  },
                      width: 100,
                      height: 36,
                      isCircle: true,
                      bgColor: Colors.white,
                      borderColor: AppColors.tint,
                      fontColor: AppColors.tint)
                ],
              ))
          : Container()
    ],
  ));
}

Widget buildHistoryOrderView(orderList) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 99,
            height: 1,
            color: const Color.fromRGBO(217, 217, 217, 1),
          ),
          const SizedBox(width: 10),
          Text(
            '历史订单',
            style: textSyle700(fontSize: 15, color: AppColors.text666),
          ),
          const SizedBox(width: 10),
          Container(
            width: 99,
            height: 1,
            color: const Color.fromRGBO(217, 217, 217, 1),
          ),
        ],
      ),
      ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: orderList.length,
        itemBuilder: (context, index) {
          final item = orderList[index];
          return Padding(
              padding: const EdgeInsets.only(top: 15),
              child: planCommonBox(Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('订单编号: ${item["orderId"]}',
                          style: textSyle700(
                              fontSize: 12, color: AppColors.text666)),
                      Text('第${orderList.length - index}笔',
                          style: textSyle700(fontSize: 12))
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    child: Divider(color: Color.fromRGBO(231, 231, 231, 1)),
                  ),
                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: item["lineItems"].length,
                      itemBuilder: (context, i) {
                        final el = item["lineItems"][i];
                        return Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: planProductItem(el["pic"], el["skuName"],
                                el["price"], el["num"]));
                      }),
                  const Padding(
                    padding: EdgeInsets.only(top: 5, bottom: 5),
                    child: Divider(color: Color.fromRGBO(231, 231, 231, 1)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('发货日期:${handleDateFromApi(item["shipmentDate"])}',
                          style: textSyle700(
                              fontSize: 12, color: AppColors.text666))
                    ],
                  )
                ],
              )));
        },
      ),
    ],
  );
}
