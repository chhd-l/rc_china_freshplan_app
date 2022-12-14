import 'package:flutter/material.dart';
import 'package:rc_china_freshplan_app/common/util/address_util.dart';
import 'package:rc_china_freshplan_app/common/util/event_bus.dart';
import 'package:rc_china_freshplan_app/common/util/utils.dart';
import 'package:rc_china_freshplan_app/common/values/colors.dart';
import 'package:rc_china_freshplan_app/common/values/const.dart';
import 'package:rc_china_freshplan_app/common/widgets/factor.dart';
import 'package:rc_china_freshplan_app/data/address.dart';
import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/common/router/app_router.dart';
import 'package:rc_china_freshplan_app/global.dart';

import 'no_address_view.dart';

class AddressManage extends StatelessWidget {
  const AddressManage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: commonAppBar('地址管理'), body: const MyStatefulWidget());
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  List<AddRess> addressList = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    var list = await AddRessUtil.getAddressList();
    setState(() {
      addressList = list;
    });
  }

  Future<void> setDefault(String id) async {
    AddRess? address =
        addressList.firstWhereOrNull((element) => element.id == id);
    setState(() {
      for (var element in addressList) {
        if (element.id == id) {
          element.isDefault = true;
        } else {
          element.isDefault = false;
        }
      }
    });
    if (address != null) {
      await AddRessUtil.updateAddRess(address);
    }
  }

  void _handleDelete(String id) {
    showTipAlertDialog(context, '您确定要删除这个地址吗？', () async {
      var deleteFlag = await AddRessUtil.removeAddRess(id);
      if (deleteFlag) {
        getData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 249, 249, 249),
        body: Column(
          children: [
            Expanded(
                child: addressList.isEmpty
                    ? noAddressView()
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: addressList.length,
                        itemBuilder: (BuildContext ctx, int i) {
                          return GestureDetector(
                              onTap: () {
                                final global = Get.put(GlobalConfigService());
                                if (global.isCheckoutSelectAddress.value) {
                                  global.isCheckoutSelectAddress.value = false;
                                  global.checkoutAddress.value = addressList[i];
                                  Get.back();
                                }
                                if (global.isPlanDetailSelectAddress.value) {
                                  global.isPlanDetailSelectAddress.value =
                                      false;
                                  EventBus().sendBroadcast(updatePlanAddress);
                                  global.planDetailAddress.value =
                                      addressList[i];
                                  Get.back();
                                }
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(2.5, 2.5),
                                          color: Color.fromRGBO(
                                              191, 191, 191, 0.1),
                                          blurRadius: 2.0,
                                          blurStyle: BlurStyle.solid,
                                          spreadRadius: 0.0)
                                    ]),
                                margin: const EdgeInsets.only(
                                    left: 12.0, right: 12.0, top: 15.0),
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                              addressList[i].receiverName ?? '',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              )),
                                        ),
                                        Expanded(
                                          child: Text(
                                              addressList[i].phone ?? '',
                                              textAlign: TextAlign.right,
                                              style: textSyle700(
                                                  fontSize: 15,
                                                  color: AppColors.text999)),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(
                                            top: 18.0, bottom: 13.0),
                                        child: Text(
                                          '${addressList[i].province as String} ${addressList[i].city as String} ${addressList[i].region as String} ${addressList[i].detail as String} ',
                                          style: textSyle700(fontSize: 14),
                                        )),
                                    const Divider(
                                        color:
                                            Color.fromARGB(255, 231, 231, 231)),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 24,
                                                  child: Radio(
                                                      visualDensity:
                                                          const VisualDensity(
                                                              horizontal: 0),
                                                      materialTapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                      value: addressList[i]
                                                          .isDefault as bool,
                                                      groupValue: true,
                                                      onChanged: (value) {
                                                        setDefault(
                                                            addressList[i].id!);
                                                      },
                                                      activeColor:
                                                          AppColors.tint),
                                                ),
                                                const SizedBox(width: 8),
                                                const Text('默认地址',
                                                    style: TextStyle(
                                                      color: AppColors.text999,
                                                    )),
                                              ]),
                                        ),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              GestureDetector(
                                                  onTap: () {
                                                    Get.toNamed(
                                                            AppRoutes
                                                                .newAddress,
                                                            arguments:
                                                                addressList[i]
                                                                    .id)
                                                        ?.then((value) => value
                                                            ? getData()
                                                            : null);
                                                  },
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 8.0),
                                                    child: Image.asset(
                                                      'assets/images/ressEdit.png',
                                                      width: 27,
                                                      height: 27,
                                                      fit: BoxFit.fitWidth,
                                                    ),
                                                  )),
                                              GestureDetector(
                                                  onTap: (() {
                                                    _handleDelete(
                                                        addressList[i].id!);
                                                  }),
                                                  child: Image.asset(
                                                    'assets/images/ressDelete.png',
                                                    width: 27,
                                                    height: 27,
                                                    fit: BoxFit.fitWidth,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ));
                        },
                      )),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.only(
                  left: 48, right: 48, top: 12, bottom: 12),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: titleButton('新增地址', () {
                Get.toNamed(AppRoutes.newAddress, arguments: '-1')
                    ?.then((value) => value ? getData() : null);
              }, isCircle: true, height: 46, fontSize: 17),
            ),
          ],
        ));
  }
}
