// import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rc_china_freshplan_app/common/values/colors.dart';
import 'package:get/get.dart';

const defaultBgColor = Color.fromARGB(255, 251, 179, 6);

Widget titleButton(String title, VoidCallback? onPressed,
    {Color bgColor = AppColors.tint,
    double fontSize = 14.0,
    double width = double.infinity,
    double height = 48,
    Color fontColor = Colors.white,
    Color borderColor = Colors.transparent,
    EdgeInsets? margin,
    bool isCircle = false,
    Widget? icon}) {
  return Container(
    width: width,
    height: height,
    margin: margin,
    decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 1.0),
        borderRadius:
            BorderRadius.all(Radius.circular(isCircle ? height / 2.0 : 4)),
        color: bgColor),
    child: MaterialButton(
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icon != null) icon,
          Text(
            title.toUpperCase(),
            style: TextStyle(
                fontFamily: 'Nunito-black',
                fontSize: fontSize.sp,
                color: fontColor,
                height: 1.5),
          )
        ],
      ),
    ),
  );
}

TextStyle textSyle900(
    {double? fontSize,
    Color color = AppColors.primaryText,
    double height = 1.5}) {
  return TextStyle(
      fontFamily: 'Nunito-black',
      fontSize: fontSize,
      color: color,
      height: height);
}

TextStyle textSyle700(
    {double? fontSize,
    Color color = AppColors.primaryText,
    double height = 1.5}) {
  return TextStyle(
      fontFamily: 'Nunito-Bold',
      fontSize: fontSize,
      color: color,
      height: height);
}

TextStyle textSyle800(
    {double? fontSize,
    Color color = AppColors.primaryText,
    double height = 1.5}) {
  return TextStyle(
      fontFamily: 'Nunito-ExtraBold',
      fontSize: fontSize,
      color: color,
      height: height);
}

TextStyle textSyle500(
    {double? fontSize,
    Color color = AppColors.primaryText,
    double height = 1.5}) {
  return TextStyle(
      fontFamily: 'Nunito-Bold',
      fontSize: fontSize,
      color: color,
      height: height);
}

TextStyle textSyle400(
    {double? fontSize,
    Color color = AppColors.primaryText,
    double height = 1.5}) {
  return TextStyle(
      fontFamily: 'Nunito-Bold',
      fontSize: fontSize,
      color: color,
      height: height);
}

PreferredSizeWidget commonAppBar(String appBarTitle,
    {bool needBack = true,
    List<Widget>? actions,
    Color bgColor = Colors.white,
    VoidCallback? onPressed}) {
  return PreferredSize(
      preferredSize: const Size.fromHeight(70.0),
      child: Container(
        color: bgColor,
        padding: const EdgeInsets.only(top: 10.0),
        child: AppBar(
          backgroundColor: bgColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(appBarTitle,
                  style: textSyle400(
                      fontSize: 18.sp,
                      color: const Color.fromRGBO(51, 51, 51, 1))),
              const SizedBox(width: 30),
            ],
          ),
          leading: needBack
              ? IconButton(
                  icon: Image.asset('assets/images/arrow-left.png'),
                  onPressed: onPressed ??
                      () {
                        Get.back();
                      })
              : Container(),
          automaticallyImplyLeading: true,
          elevation: 0,
          actions: actions,
        ),
      ));
}
