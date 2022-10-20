import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class TabsController extends GetxController {
  var tab = 0.obs;

  void changeTab(int key) {
    tab.value = key;
  }
}

class PetTabWidget extends StatefulWidget {
  const PetTabWidget({Key? key}) : super(key: key);

  @override
  _PetTabWidgetState createState() => _PetTabWidgetState();
}

class _PetTabWidgetState extends State<PetTabWidget>
    with SingleTickerProviderStateMixin {
  List tabs = ["基本信息", "体征档案"];
  TabController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      length: tabs.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  Widget _tabBar() {
    return Container(
      height: 56,
      color: Colors.white,
      child: TabBar(
          controller: _controller,
          labelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          labelColor: Colors.green,
          unselectedLabelColor: Colors.black26,
          indicator: const UnderlineTabIndicator(
              insets: EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              borderSide: BorderSide(
                width: 4,
                color: Colors.green,
              )),
          tabs: tabs
              .map((e) => Tab(
                    text: e,
                  ))
              .toList()),
    );
  }

  Widget _body() {
    return TabBarView(
      controller: _controller,
      children: tabs.map((item) {
        return Center(
          child: Text(item),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          _tabBar(),
          Expanded(
            child: _body(),
          ),
        ],
      ),
    );
  }
}
