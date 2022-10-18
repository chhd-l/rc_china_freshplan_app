import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/common/values/colors.dart';
import 'package:rc_china_freshplan_app/common/widgets/factor.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'logic.dart';

class InvoiceManagePage extends StatelessWidget {
  InvoiceManagePage({super.key});

  final PlanDetailLogic logic = Get.put(PlanDetailLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: commonAppBar('发票管理', bgColor: AppColors.bgLinearGradient1),
      body: Obx(() => logic.url.value != ''
          ? WebView(initialUrl: logic.url.value)
          : Container()),
    );
  }
}
