import 'package:flutter/material.dart';

class ProgressView extends StatelessWidget {
  const ProgressView(
      {Key? key,
      this.tintColor = Colors.grey,
      this.progressWidth = 100,
      required this.colors,
      this.stops})
      : super(key: key);

  final Color tintColor;
  final double progressWidth;
  final List<double>? stops;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    Widget indicater = Container(
      color: tintColor,
      width: 1,
      height: 14,
    );

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          border: Border.all(color: tintColor, width: 2)),
      child: Stack(
        children: <Widget>[
          Container(
            height: 14,
            decoration: new BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    stops: stops,
                    colors: colors)),
          ),
          Positioned(
            child: Container(
              color: Colors.white,
              height: 14,
            ),
            left: progressWidth,
            right: 0,
          ),
          Positioned(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [indicater, indicater, indicater, indicater, indicater],
            ),
          )
        ],
      ),
    );
  }
}
