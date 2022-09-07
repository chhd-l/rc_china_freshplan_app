import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/common/values/values.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 信息提示
/// msg 提示
/// backgroundColor 背景颜色
/// textColor 字体颜色
///
/// 确认弹出框
// void showConfirmDialog(String content,
//     {VoidCallback? confirmCallback, Function? cancelCallback}) async {
//   Get.defaultDialog(
//       title: DIALOG_TITLE,
//       content: Text(content),
//       onConfirm: confirmCallback,
//       onCancel: () {},
//       textCancel: CANCEL_TEXT,
//       textConfirm: CONFIRM_TEXT);
// }

/// 底部菜单
// void orShowBottomSheet(String title, int count, Function itemCallback,
//     {selected}) {
//   Widget divider = Divider(
//     color: AppColors.tabCellSeparator,
//   );
//
//   Get.bottomSheet(
//     Column(
//       children: [
//         orSheetBar(title),
//         Expanded(
//             child: ListView.separated(
//           itemBuilder: (BuildContext context, int index) {
//             return itemCallback(index);
//           },
//           itemCount: count,
//           separatorBuilder: (BuildContext context, int index) {
//             return divider;
//           },
//         )),
//       ],
//     ),
//     backgroundColor: Colors.white,
//     shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//       topLeft: Radius.circular(12.w),
//       topRight: Radius.circular(12.w),
//     )),
//   );
// }

Widget orSheetBar(String title) {
  return Container(
    height: 50.h,
    padding: EdgeInsets.fromLTRB(15.w, 0, 15.w, 0),
    decoration: BoxDecoration(
      color: Color.fromRGBO(240, 240, 240, 1),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12.w),
        topRight: Radius.circular(12.w),
      ),
    ),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      InkWell(
        child: Text('Cancel',
            style: TextStyle(
                fontSize: 16.sp, color: Color.fromRGBO(51, 51, 51, 1))),
        onTap: () => {Get.back()},
      ),
      Text(title,
          style: TextStyle(
              fontSize: 17.sp,
              color: Color.fromRGBO(51, 51, 51, 1),
              fontWeight: FontWeight.w600)),
      Container(
        width: 30.w,
      ),
    ]),
  );
}
