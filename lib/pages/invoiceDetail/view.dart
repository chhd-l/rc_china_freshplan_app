import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/common/widgets/factor.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'logic.dart';

class InvoiceDetailPage extends StatelessWidget {
  InvoiceDetailPage({super.key});

  final PlanDetailLogic logic = Get.put(PlanDetailLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          PreferredSize(
              preferredSize: const Size.fromHeight(70.0),
              child: Container(
                padding: const EdgeInsets.only(top: 60.0),
                color: Colors.white,
                child: Row(
                  children: [
                    IconButton(
                        icon: Image.asset('assets/images/arrow-left.png'),
                        onPressed: () {
                          logic.webViewController.canGoBack().then((value) {
                            if (value) {
                              logic.webViewController.goBack();
                            } else {
                              Get.back();
                            }
                          });
                        }),
                    Obx(() => Text(logic.title.value,
                        style: textSyle400(fontSize: 18))),
                    const SizedBox(width: 30),
                  ],
                ),
              )),
          Expanded(
              child: Obx(() => logic.url.value != ''
                  ? WebView(
                      initialUrl: logic.url.value,
                      onWebViewCreated: (WebViewController controller) {
                        //页面加载的时候可以获取到controller可以用来reload等操作
                        logic.webViewController = controller;
                      },
                      javascriptChannels: logic.loadJavascriptChannel(context),
                      onPageFinished: (String url) {
                        logic.loadTitle();
                      },
                      onPageStarted: (String url) {
                        logic.loadTitle();
                      },
                      javascriptMode: JavascriptMode.unrestricted,
                      gestureNavigationEnabled: true,
                      navigationDelegate: (NavigationRequest request) {
                        logic.loadTitle();
                        return NavigationDecision.navigate;
                      },
                    )
                  : Container())),
        ],
      ),
    );
  }
}
