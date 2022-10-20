import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rc_china_freshplan_app/common/values/colors.dart';

class TimerButton extends StatefulWidget {
  final String text;
  final bool Function()? onTap;

  const TimerButton(this.text, {super.key, this.onTap});

  @override
  State createState() => _TimerButtonState();
}

class _TimerButtonState extends State<TimerButton> {
  Timer? _timer;
  int _timeOut = 60;
  String _text = '';
  bool _disabled = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
          width: 120,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 244, 244, 244),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              _text,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.tint,
              ),
            ),
          )),
      onTap: () {
        if (!_disabled && (widget.onTap == null || widget.onTap!())) {
          _startTimer();
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _text = widget.text;
  }

  _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _timeOut--;
        _disabled = true;
        _text = '${_timeOut}s';
      });
      if (_timeOut == 0) {
        _cancelTimer();
        _text = widget.text;
        _timeOut = 60;
      }
    });
  }

  _cancelTimer() {
    if (_timer != null) {
      _timer?.cancel();
      _timer = null;
    }
    _disabled = false;
  }

  @override
  void dispose() {
    super.dispose();
    _cancelTimer();
  }
}
