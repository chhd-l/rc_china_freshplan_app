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

// Widget textButton(String text, VoidCallback onPressed,
//     {Color fontColor = AppColors.tint, double fontSize = 14.0}) {
//   return GestureDetector(
//     child: Text(
//       text,
//       style: TextStyle(
//           fontFamily: 'Nunito-black', fontSize: fontSize, color: fontColor),
//     ),
//     onTap: onPressed,
//   );
// }

Widget backgroundContainer(Widget child,
    {safeAreaBottom = true, pading = EdgeInsets.zero}) {
  return Container(
    decoration: BoxDecoration(
        image: DecorationImage(
      image: AssetImage('assets/images/yellow_bg.png'),
      fit: BoxFit.cover,
    )),
    child: SafeArea(bottom: safeAreaBottom, child: child),
    padding: pading,
    height: double.infinity,
  );
}

Widget titleToast(String title,
    {Color bgColor = defaultBgColor, Color fontColor = Colors.black}) {
  if (title.length <= 0) return Container();
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5.0),
      boxShadow: [
        BoxShadow(offset: Offset(2, 2), color: Colors.grey, blurRadius: 5.0)
      ],
      color: bgColor,
    ),
    child: Text(title,
        style: TextStyle(
            fontSize: 12.sp, fontFamily: 'Nunito-Black', color: fontColor)),
  );
}

Widget bottomContainer(Widget widget, {double? height, EdgeInsets? padding}) =>
    Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      ),
      padding: padding != null ? padding : EdgeInsets.all(24),
      child: widget,
      height: height,
    );

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
    bool titleIsImage = false,
    String imageTitle = 'assets/images/fresh-plan-logo.png'}) {
  return PreferredSize(
      preferredSize: const Size.fromHeight(70.0),
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: AppBar(
          backgroundColor: bgColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              !titleIsImage
                  ? Container(
                      margin: const EdgeInsets.only(right: 20.0),
                      child: Text(appBarTitle,
                          style: textSyle400(
                              fontSize: 18.sp,
                              color: const Color.fromRGBO(51, 51, 51, 1))),
                    )
                  : Image.asset(imageTitle),
            ],
          ),
          leading: needBack
              ? IconButton(
                  icon: Image.asset('assets/images/arrow-left.png'),
                  onPressed: () {
                    Get.back();
                  })
              : null,
          automaticallyImplyLeading: true,
          elevation: 0,
          actions: actions,
        ),
      ));
}
