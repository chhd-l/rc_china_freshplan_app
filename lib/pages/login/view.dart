import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/common/router/app_router.dart';
import 'package:rc_china_freshplan_app/data/consumer.dart';
import 'package:rc_china_freshplan_app/common/util/storage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Consumer consumer = Consumer(
      name: '测试用户',
      nickName: '测试用户',
      storeId: '39b6444b-683b-4915-8b75-5d8403f40a02');
  String _password = '';

  void _onPressLogin() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      StorageUtil().setJSON('loginUser', consumer.toJson());
      Get.toNamed(AppRoutes.account);
    }
    //Get.toNamed(AppRoutes.account);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('登录'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '登录',
              style: TextStyle(
                  fontSize: 32,
                  color: Color.fromARGB(255, 51, 51, 51),
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      hintText: '手机号',
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 222, 222, 222),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 237, 237, 237),
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.phone_android_outlined,
                        size: 22,
                        color: Color.fromARGB(255, 153, 153, 153),
                      ),
                    ),
                    validator: (value) {
                      RegExp reg = RegExp(
                          r'^1(?:3\d|4[4-9]|5[0-35-9]|6[67]|7[013-8]|8\d|9\d)\d{8}$');
                      if (!reg.hasMatch(value!)) {
                        return '请输入正确的手机号码';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      consumer.mobile = value ?? '';
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: '密码',
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 222, 222, 222),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 237, 237, 237),
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        size: 22,
                        color: Color.fromARGB(255, 153, 153, 153),
                      ),
                    ),
                    validator: (value) {
                      if (value == '') {
                        return '请输入密码';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _password = value ?? '';
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: MaterialButton(
                    color: const Color.fromARGB(255, 150, 204, 57),
                    textColor: Colors.white,
                    onPressed: () {
                      _onPressLogin();
                    },
                    elevation: 0,
                    height: 46,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(23)),
                    ),
                    child: const Text('登录'),
                  ),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
