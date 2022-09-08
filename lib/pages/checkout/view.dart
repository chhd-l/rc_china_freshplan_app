import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rc_china_freshplan_app/common/values/colors.dart';
import 'package:rc_china_freshplan_app/common/widgets/factor.dart';
import 'package:rc_china_freshplan_app/common/widgets/textFields.dart';
import 'package:rc_china_freshplan_app/common/router/app_router.dart';
import 'package:rc_china_freshplan_app/pages/pet/createPet/common-widget-view.dart';

import 'logic.dart';

class CheckoutPage extends StatelessWidget {
  CheckoutPage({super.key});

  final CheckoutLogic logic = Get.put(CheckoutLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(191, 191, 191, 0.1),
        appBar: commonAppBar('确认订单'),
        body: SafeArea(
          child: Column(children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                    right: 12.w, left: 12.w, top: 24.w, bottom: 16.h),
                child: Column(children: [
                  commonContainer(
                      74.5,
                      Row(
                        children: [
                          Image.asset('assets/images/address.png'),
                          const SizedBox(width: 8),
                          Text(
                            '添加收货地址',
                            style: textSyle700(
                                fontSize: 17,
                                color: const Color.fromRGBO(51, 51, 51, 1)),
                          ),
                          const Spacer(),
                          Image.asset('assets/images/arrow-right.png'),
                        ],
                      )),
                  commonContainer(
                      282.5,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '订单商品',
                            style: textSyle700(
                                fontSize: 17,
                                color: const Color.fromRGBO(51, 51, 51, 1)),
                          ),
                         Row(children: [
                           Image.asset('assets/images/牛肉泥.png'),

                         ],)
                        ],
                      )),
                ]),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                        color: AppColors.tabCellSeparator, width: 1.0),
                  ),
                  color: Colors.white),
              padding: EdgeInsets.fromLTRB(24.w, 19.h, 24.w, 19.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                        style: textSyle700(
                            fontSize: 16,
                            color: const Color.fromRGBO(51, 51, 51, 1)),
                        children: const [
                          TextSpan(text: '应付：'),
                          TextSpan(
                            text: '￥90.00',
                            style: TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(212, 157, 40, 1)),
                          ),
                        ]),
                  ),
                  titleButton('支付', () {
                    Get.offAllNamed(AppRoutes.recommendRecipes);
                  }, width: 114, isCircle: true, height: 36)
                ],
              ),
            )
          ]),
        ));
  }
}

Widget commonContainer(double height, Widget child) {
  return Container(
    height: height,
    padding: const EdgeInsets.all(16),
    margin: const EdgeInsets.only(bottom: 15),
    decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 0),
              color: Color.fromRGBO(191, 191, 191, 0.1),
              blurRadius: 2.0,
              blurStyle: BlurStyle.solid,
              spreadRadius: 0.0)
        ]),
    child: child,
  );
}
