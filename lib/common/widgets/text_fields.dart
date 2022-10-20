// import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:rc_china_freshplan_app/common/values/values.dart';

Widget textFiled(
    {int? maxLength,
    String? icon,
    String? hintText,
    bool obscureText = false,
    TextEditingController? controller,
    FocusNode? focusNode,
    TextInputType? keyboardType,
    bool showErrorBorder = false,
    String? errorText,
    String? suffixText,
    Widget? suffix,
    TextStyle? style,
    double borderWidth = 1,
    double borderRadius = 4,
    double verticalPadding = 14,
    int lengthLimit = 20,
    bool autoFocus = false,
    VoidCallback? onEditingComplete,
    VoidCallback? onTap,
    TextStyle? hintStyle,
    int? maxLines = 1,
    Color? fillColor,
    TextAlign? textAlign = TextAlign.start}) {
  final OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(borderRadius),
    ),
    borderSide: BorderSide(
      color: showErrorBorder
          ? const Color.fromARGB(255, 249, 91, 1)
          : const Color.fromRGBO(246, 246, 246, 1),
      width: borderWidth,
    ),
  );

  return TextField(
      maxLength: maxLength,
      autofocus: autoFocus,
      keyboardType: keyboardType,
      controller: controller,
      focusNode: focusNode,
      textAlign: textAlign ?? TextAlign.start,
      inputFormatters: [LengthLimitingTextInputFormatter(lengthLimit)],
      decoration: InputDecoration(
        counterText: "",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding:
            EdgeInsets.symmetric(horizontal: 9, vertical: verticalPadding),
        prefixIcon: icon == null ? null : Image.asset(icon),
        suffixText: suffixText,
        suffixIcon: suffix,
        suffixIconConstraints: BoxConstraints(minWidth: 25, minHeight: 0),
        errorText: errorText,
        errorStyle: TextStyle(
          color: Color.fromARGB(255, 255, 87, 53),
          fontSize: 12.sp,
        ),
        errorMaxLines: 3,
        hintText: hintText,
        hintMaxLines: 2,
        enabledBorder: border,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius),
          ),
          borderSide: BorderSide(
            color: AppColors.tint,
            width: borderWidth,
          ),
        ),
        errorBorder: border,
        focusedErrorBorder: border,
        fillColor: fillColor ?? const Color.fromRGBO(246, 246, 246, 1),
        filled: true,
        hintStyle: hintStyle ?? TextStyle(fontSize: 16.sp),
      ),
      style: style ?? TextStyle(fontSize: 16.sp),
      obscureText: obscureText,
      onEditingComplete: onEditingComplete,
      onTap: onTap,
      maxLines: maxLines);
}

Widget titleTextFiled(String title,
    {String? hintText,
    bool obscureText = false,
    TextEditingController? controller,
    FocusNode? focusNode,
    int lengthLimit = 20,
    TextInputType? keyboardType,
    String? errorText,
    Color titleColor = Colors.white}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(fontSize: 16.sp, color: titleColor),
      ),
      SizedBox(
        height: 5.h,
      ),
      textFiled(
          hintText: hintText,
          obscureText: obscureText,
          controller: controller,
          lengthLimit: lengthLimit,
          focusNode: focusNode,
          keyboardType: keyboardType,
          errorText: errorText)
    ],
  );
}

Widget passwordTextFiled(
    {TextEditingController? controller,
    FocusNode? focusNode,
    String title = '',
    bool obscureText = false,
    bool showSeeIcon = true,
    bool showErrorBorder = false,
    VoidCallback? obscureOnPressed,
    Color titleColor = AppColors.primaryText}) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(title, style: TextStyle(fontSize: 16.sp, color: titleColor)),
    SizedBox(
      height: 5.h,
    ),
    Stack(
      alignment: Alignment.center,
      children: [
        textFiled(
            controller: controller,
            focusNode: focusNode,
            obscureText: obscureText,
            showErrorBorder: showErrorBorder,
            keyboardType: TextInputType.visiblePassword),
        showSeeIcon
            ? Positioned(
                right: 10,
                child: IconButton(
                    icon: Image.asset(
                        'assets/images/${obscureText ? 'close_eye' : 'open_eye'}.png'),
                    onPressed: obscureOnPressed),
              )
            : Container()
      ],
    ),
  ]);
}
