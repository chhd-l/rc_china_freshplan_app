import 'package:flutter/material.dart';

Widget emptyData(){
  return Container(
    width: double.infinity,
    height: double.infinity,
    child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: SizedBox(),
          flex: 1,
        ),
        SizedBox(
          width: 100.0,
          height: 70.0,
          child: Icon(Icons.all_inbox_sharp,size: 60,color: Colors.grey,),
        ),
        Text(
          "暂无数据",
          style: TextStyle(fontSize: 16.0, color: Colors.grey[400]),
        ),
        Expanded(
          child: SizedBox(),
          flex: 3,
        ),
      ],
    ),
  );
}