import 'package:flutter/material.dart';

class NumberControllerWidget extends StatefulWidget {
  //高度
  final double height;
  //输入框的宽度 总体宽度为自适应
  final double width;
  //按钮的宽度
  final double iconWidth;
  //默认输入框显示的数量
  final String numText;
  //点击加减号任意一个回调 数量值改变
  final ValueChanged updateValueChanged;
  // 最大值
  final int maxValue;

  NumberControllerWidget(
      {this.height = 40,
      this.width = 40,
      this.iconWidth = 40,
      this.numText = '0',
      required this.updateValueChanged,
      this.maxValue = 0});
  @override
  _NumberControllerWidgetState createState() => _NumberControllerWidgetState();
}

class _NumberControllerWidgetState extends State<NumberControllerWidget> {
  var textController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    this.textController.text = widget.numText;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          height: widget.height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                  width: 1, color: Color.fromRGBO(230, 230, 230, 1))),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              //减号
              customIconButton(
                  icon: Icons.remove, isAdd: false, context: context),
              //输入框
              SizedBox(
                width: widget.width,
                child: TextField(
                  controller: textController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 16, color: Color.fromRGBO(77, 77, 77, 1)),
                  enableInteractiveSelection: false,
                  decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.only(left: 0, top: 2, bottom: 2, right: 0),
                    border: OutlineInputBorder(
                      gapPadding: 0,
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                  ),
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    var num = int.parse(textController.text);
                    if (widget.maxValue != 0 && num > widget.maxValue) {
                      num = widget.maxValue;
                    }
                    textController.text = '$num';
                    widget.updateValueChanged(num);
                  },
                ),
              ),
              //加号
              customIconButton(icon: Icons.add, isAdd: true, context: context),
            ],
          ),
        )
      ],
    );
  }

  Widget customIconButton(
      {required IconData icon,
      required bool isAdd,
      required BuildContext context}) {
    return Container(
      width: widget.iconWidth,
      child: IconButton(
        padding: const EdgeInsets.all(0),
        icon: Icon(icon),
        color: const Color.fromRGBO(77, 77, 77, 1),
        onPressed: () {
          FocusScope.of(context).requestFocus(FocusNode());
          var num = int.parse(textController.text);
          if (!isAdd && num == 0) return;
          if (isAdd) {
            num++;
          } else {
            num--;
          }
          if (widget.maxValue != 0 && num > widget.maxValue) {
            num = widget.maxValue;
          }
          textController.text = '$num';
          widget.updateValueChanged(num);
        },
      ),
    );
  }
}
