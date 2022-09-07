import 'package:flutter/material.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 251, 179, 6),
      body: Column(children: [
        const SizedBox(height: 100,),
        Image.asset('assets/images/homeward.png',
            width: 51, fit: BoxFit.fitWidth),
        const Text('welcome to rc_china_freshplan_app',style: TextStyle(fontSize: 20),)
      ]),
    );
  }
}
