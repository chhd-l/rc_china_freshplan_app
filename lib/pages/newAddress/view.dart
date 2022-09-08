import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:rc_china_freshplan_app/common/widgets/factor.dart';

// ignore: camel_case_types
class newAddress extends StatelessWidget {

  const newAddress({super.key, required this.name, required this.phone, required this.details, required this.cite, required this.open});

  final String name;
  final String phone;
  final String details;
  final String cite;
  final bool open;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: commonAppBar('新增地址'),
        body: const MyStatefulWidget(key: null,),
        bottomNavigationBar:  Container(
            padding: const EdgeInsets.only(bottom:12.0),
            decoration: const BoxDecoration(
                color: Colors.white,
            ),
            child: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, top: 12),
            child: titleButton('保存', () {
              Navigator.of(context).pop();
            },
                isCircle: true,
                fontSize: 18,
                height: 38
          ),
        ),                      
        )  
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

var _site = false;

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
          padding: const EdgeInsets.all(12),
          color:const Color.fromARGB(255, 249, 249, 249),
          child: ListView.builder(
          shrinkWrap: true,
          itemCount: 1,
          itemBuilder: (BuildContext ctx, int i) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15)),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(2.5, 2.5),
                      color: Color.fromRGBO(191, 191, 191, 0.1),
                      blurRadius: 2.0,
                      blurStyle: BlurStyle.solid,
                      spreadRadius: 0.0)
                ]),
              child: Column(children: [
              Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(children: const [
                Expanded(child: Text('收货人')),
                Expanded(flex: 3,child: TextField(
                  decoration: InputDecoration(
                    hintText: '请输入姓名',
                    hintStyle: TextStyle(
                      fontSize: 13
                      ),
                    border: InputBorder.none
                      )
                    ),
                  )
                ])
              ),
              Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(children: const [
                Expanded(child: Text('联系电话')),
                Expanded(flex: 3,child: TextField(
                  decoration: InputDecoration(
                    hintText: '请输入联系电话',
                    hintStyle: TextStyle(
                      fontSize: 13
                      ),
                    border: InputBorder.none
                      )
                    ),
                  )
                ])
              ),
              Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(children: const [
                Expanded(child: Text('所在地区')),
                Expanded(flex: 3,child: TextField(
                  decoration: InputDecoration(
                    hintText: '省，市，区',
                    hintStyle: TextStyle(
                      fontSize: 13
                      ),
                    border: InputBorder.none
                      )
                    ),
                  )
                ])
              ),
              Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: const [
                Expanded(child: Text('详细地址')),
                Expanded(flex: 3,child: TextField(
                  decoration: InputDecoration(
                    hintText: '请输入详细地址',
                    hintStyle: TextStyle(
                      fontSize: 13
                      ),
                    border: InputBorder.none
                      )
                    ),
                  )
                ])
              ),
              Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  const Text('默认地址'),
                  Switch(
                    value: _site, 
                    onChanged: (value){
                      setState(() {
                          _site = !_site;
                      });
                    }
                  )
                ])
              ),
            ])
          );
        }),
      );
  }
}