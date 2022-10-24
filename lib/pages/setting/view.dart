import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/common/util/utils.dart';

import 'package:rc_china_freshplan_app/common/values/colors.dart';
import 'package:rc_china_freshplan_app/common/widgets/factor.dart';
import 'package:rc_china_freshplan_app/pages/account/common_view.dart';

import 'logic.dart';

class SettingPage extends StatelessWidget {
  SettingPage({super.key});

  final SettingLogic logic = Get.put(SettingLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: commonAppBar('账号管理'),
        backgroundColor: const Color.fromARGB(255, 249, 249, 249),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  margin:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                  child: GestureDetector(
                    child: commonBoxTitle(
                      'assets/images/sign_out.png',
                      '退出登录',
                    ),
                    onTap: () {
                      showTipAlertDialog(context, '您确定退出登录吗？', () {
                        logic.signOut();
                      });
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: GestureDetector(
                    child: commonBoxTitle(
                      'assets/images/logout.png',
                      '注销账号',
                    ),
                    onTap: () {
                      showTipAlertDialog(context, '您确定注销该账号吗？', () {
                        logic.logout();
                      });
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
