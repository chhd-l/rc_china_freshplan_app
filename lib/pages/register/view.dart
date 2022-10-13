import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/common/router/app_router.dart';
import 'package:rc_china_freshplan_app/common/util/event_bus.dart';
import 'package:rc_china_freshplan_app/data/consumer.dart';
import 'package:rc_china_freshplan_app/common/util/storage.dart';
import 'package:rc_china_freshplan_app/global.dart';
import 'package:rc_china_freshplan_app/common/util/pet-util.dart';
import 'package:rc_china_freshplan_app/common/util/address-util.dart';
import 'package:rc_china_freshplan_app/api/consumer/index.dart';
import 'package:rc_china_freshplan_app/common/widgets/timerButton.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  String phone = '';
  String validationCode = '';
  String password = '';
  bool showPassword = false;
  bool showConfirmPassword = false;

  void _onPressLogin() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      var db = await ConsumerEndPoint.registerByPhone(
          phone, validationCode, password);
      if (db != false) {
        EasyLoading.showToast("注册成功");
        Get.offNamed(AppRoutes.login);
      }
    }
    //Get.toNamed(AppRoutes.account);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('注册'),
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
              '注册',
              style: TextStyle(
                fontSize: 32,
                color: Color.fromARGB(255, 51, 51, 51),
              ),
            ),
            Container(
              width: 64,
              height: 8,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 228, 254, 183),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Text(
                  '已有账号，直接去',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 153, 153, 153),
                  ),
                ),
                GestureDetector(
                  child: const Text(
                    '登录',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 150, 204, 57),
                    ),
                  ),
                  onTap: () {
                    Get.offNamed(AppRoutes.login);
                  },
                ),
              ],
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
                    controller: phoneController,
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
                      phone = value ?? '';
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: '验证码',
                      hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 222, 222, 222),
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 237, 237, 237),
                        ),
                      ),
                      prefixIcon: const Icon(
                        Icons.security_outlined,
                        size: 22,
                        color: Color.fromARGB(255, 153, 153, 153),
                      ),
                      suffixIcon: TimerButton(
                        '获取验证码',
                        onTap: () {
                          RegExp reg = RegExp(
                              r'^1(?:3\d|4[4-9]|5[0-35-9]|6[67]|7[013-8]|8\d|9\d)\d{8}$');
                          if (!reg.hasMatch(phoneController.text)) {
                            EasyLoading.showToast('请输入正确的手机号码');
                            return false;
                          }
                          ConsumerEndPoint.sendVerificationCode(
                              phoneController.text, "REGISTER");
                          return true;
                        },
                      ),
                      suffixIconConstraints:
                          const BoxConstraints(maxHeight: 30),
                    ),
                    validator: (value) {
                      if (value == '') {
                        return '请输入验证码';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      validationCode = value ?? '';
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    obscureText: !showPassword,
                    controller: passwordController,
                    decoration: InputDecoration(
                      hintText: '6-16位密码，区分大小写',
                      hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 222, 222, 222),
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 237, 237, 237),
                        ),
                      ),
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        size: 22,
                        color: Color.fromARGB(255, 153, 153, 153),
                      ),
                      suffixIcon: GestureDetector(
                        child: Icon(
                          showPassword
                              ? CupertinoIcons.eye_slash
                              : CupertinoIcons.eye,
                          size: 22,
                          color: const Color.fromARGB(255, 153, 153, 153),
                        ),
                        onTap: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if ((value?.length ?? 0) < 6 ||
                          (value?.length ?? 0) > 16) {
                        return '请输入6-16位密码';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      password = value ?? '';
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    obscureText: !showConfirmPassword,
                    decoration: InputDecoration(
                      hintText: '确认密码',
                      hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 222, 222, 222),
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 237, 237, 237),
                        ),
                      ),
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        size: 22,
                        color: Color.fromARGB(255, 153, 153, 153),
                      ),
                      suffixIcon: GestureDetector(
                        child: Icon(
                          showConfirmPassword
                              ? CupertinoIcons.eye_slash
                              : CupertinoIcons.eye,
                          size: 22,
                          color: const Color.fromARGB(255, 153, 153, 153),
                        ),
                        onTap: () {
                          setState(() {
                            showConfirmPassword = !showConfirmPassword;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value != passwordController.text) {
                        return '两次输入的密码不匹配';
                      }
                      return null;
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
                    child: const Text('注册'),
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
