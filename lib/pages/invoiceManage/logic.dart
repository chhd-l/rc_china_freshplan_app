import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/api/consumer/index.dart';
import 'package:rc_china_freshplan_app/common/util/httpForThree.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PlanDetailLogic extends GetxController {
  final appSecret = '5ate975gpiv9we6p';
  final appKey = 'N790KtqEKXZujq08';

  RxString url = ''.obs;
  RxString title = '发票管理'.obs;
  RxBool canGoBack = true.obs;

  late WebViewController webViewController;

  @override
  void onReady() {
    getInvoiceToken();
    super.onReady();
  }

  getInvoiceToken() {
    String consumerId = ConsumerEndPoint.getLoggedConsumerId();
    EasyLoading.show();
    HttpUtil().get('https://fapiao-api.easyapi.com/access-token', params: {
      "appKey": appKey,
      "appSecret": appSecret,
      "username": consumerId,
    }).onError((ErrorEntity error, stackTrace) {
      EasyLoading.showError(error.message!);
    }).then((value) async {
      EasyLoading.dismiss();
      if (value == null) return;
      value = json.decode(value.toString());
      if (value["code"] != 1) {
        EasyLoading.showError(value["message"] ?? '获取token失败');
        return;
      }
      url.value =
          'https://fapiao-h5.easyapi.com?accessToken=${value["content"]["accessToken"]}';
    });
  }

  /// 获取当前加载页面的 title
  Future<void> loadTitle() async {
    final String temp = await webViewController.getTitle() ?? '发票管理';
    title.value = temp;
  }

  Set<JavascriptChannel> loadJavascriptChannel(BuildContext context) {
    final Set<JavascriptChannel> channels = <JavascriptChannel>{};
    JavascriptChannel toastChannel = JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          SnackBar(content: Text(message.message));
        });
    channels.add(toastChannel);
    return channels;
  }
}
