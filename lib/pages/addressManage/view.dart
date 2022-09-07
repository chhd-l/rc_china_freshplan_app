import 'package:flutter/material.dart';

class AddRessManage extends StatelessWidget {
  const AddRessManage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  const Color.fromARGB(255, 198, 198, 198),
      body: ListView.builder(
          itemCount: 2, 
          itemBuilder: (BuildContext ctx, int i) {
          return Container(
              margin: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12.0),
              padding: const EdgeInsets.all(12.0),
              color:  const Color.fromARGB(255, 255, 255, 255),
              child: 
                Column(
                  children:  [
                    Row(
                      children: const [
                        Expanded( 
                          child: Text('我的'),
                        ),
                        Expanded(
                          child: Text('18723489950', textAlign: TextAlign.right,),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                      child: const Text('重庆市 重庆市 沙坪坝区 重庆市沙坪坝区 重庆某某某街道学')
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => {
                              
                            },
                            child: const Text('我的')
                          ),
                        ),
                        const Expanded(
                          child: Text('18723489950', textAlign: TextAlign.right,),
                        ),
                      ],
                    ),
                  ],
                ),
            );
          },
        )
      );
  }
}
