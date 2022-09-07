import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'common/router/app_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (c, w) => GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: GetMaterialApp(
                // translations: Languages(), // 加载翻译初始化
                locale: window.locale, //跟随系统
                fallbackLocale: const Locale('en', 'US'),
                debugShowCheckedModeBanner: false,
                initialRoute: AppPages.initial,
                getPages: AppPages.routes,
                theme: ThemeData(
                    appBarTheme: const AppBarTheme(
                        backgroundColor: Color.fromRGBO(250, 250, 250, 1),
                        foregroundColor: Color.fromARGB(255, 77, 77, 77)),
                    primaryColor: Colors.white,
                    fontFamily: 'Nunito-Bold',
                    scaffoldBackgroundColor:
                        const Color.fromRGBO(250, 250, 250, 1)),
                builder: EasyLoading.init(),
              ),
            ));
  }
}
