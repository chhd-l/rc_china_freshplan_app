// ignore_for_file: sort_child_properties_last

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rc_china_freshplan_app/common/router/app_router.dart';
import 'package:rc_china_freshplan_app/common/util/event_bus.dart';
import 'package:rc_china_freshplan_app/common/values/colors.dart';
import 'package:rc_china_freshplan_app/data/consumer.dart';
import 'package:rc_china_freshplan_app/common/util/storage.dart';
import 'package:rc_china_freshplan_app/global.dart';
import 'package:rc_china_freshplan_app/common/util/pet_util.dart';
import 'package:rc_china_freshplan_app/common/util/address_util.dart';
import 'package:rc_china_freshplan_app/api/consumer/index.dart';

import 'logic.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final global = Get.put(GlobalConfigService());
  final LoginLogic logic = Get.put(LoginLogic());

  Consumer consumer = Consumer(
      name: '测试用户',
      nickName: '测试用户',
      storeId: '39b6444b-683b-4915-8b75-5d8403f40a02');
  String _password = '';

  void _onPressLogin() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      var db = await ConsumerEndPoint.appLogin(consumer.phone!, _password);
      if (db != false) {
        StorageUtil().setStr('accessToken', db['access_token']);
        consumer.id = db['userInfo']['id'];
        consumer.name = db['userInfo']['name'];
        consumer.gender = db['userInfo']['gender'];
        consumer.nickName = db['userInfo']['nickName'];
        consumer.avatarUrl = db['userInfo']['avatarUrl'];
        consumer.storeId = db['userInfo']['storeId'];
        consumer.email = db['userInfo']['email'];
        consumer.level = db['userInfo']['level'];
        consumer.points = db['userInfo']['points'];
        consumer.defaultConsumerAddressId =
            db['userInfo']['defaultConsumerAddressId'];
        consumer.lastLoginTime = db['userInfo']['lastLoginTime'];
        StorageUtil().setJSON('loginUser', consumer.toJson());
        StorageUtil().setJSON('consumerAccount', db['consumerAccount']);
        EventBus().sendBroadcast('user-login');
        PetUtil.init();
        AddRessUtil.init();
        Get.offNamed(AppRoutes.account);
      }
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
                  '还没有账号，立即',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 153, 153, 153),
                  ),
                ),
                GestureDetector(
                  child: const Text(
                    '注册',
                    style: TextStyle(
                      fontSize: 20,
                      color: AppColors.tint,
                    ),
                  ),
                  onTap: () {
                    Get.toNamed(AppRoutes.register);
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
                      // if (global.userList.indexWhere((element) =>
                      //         element['mobile'].toString() == value) <
                      //     0) {
                      //   return '手机号不正确';
                      // }
                      return null;
                    },
                    onSaved: (value) {
                      // var user = global.userList.firstWhere(
                      //     (element) => element['mobile'].toString() == value);
                      consumer.phone = value ?? '';
                      // consumer.name = user['name'].toString();
                      // consumer.nickName = user['name'].toString();
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
                      // if (value != '1qaz2wsx' &&
                      //     value != 'Qweruiop@123' &&
                      //     value != 'Qweruiop@12345') {
                      //   return '密码不正确';
                      // }
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
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  child: const Text(
                    '忘记密码',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 51, 51, 51),
                    ),
                  ),
                  onTap: () {
                    Get.toNamed(AppRoutes.resetPasswordStep1);
                  },
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: MaterialButton(
                    color: AppColors.tint,
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
            const SizedBox(height: 200),
            Row(children: const [
              SizedBox(width: 10),
              Expanded(child: Divider()),
              SizedBox(width: 10),
              Text('其他方式登录', style: TextStyle(fontSize: 12)),
              SizedBox(width: 10),
              Expanded(child: Divider()),
              SizedBox(width: 10),
            ]),
            const SizedBox(height: 5),
            Center(
                child: CupertinoButton(
                    child: const Image(
                      image: AssetImage('assets/images/ali_logo.png'),
                      height: 40,
                    ),
                    onPressed: (() {
                      logic.pay();
                    }))),
            const SizedBox(height: 32),
          ],
        ),
      )),
    );
  }
}
