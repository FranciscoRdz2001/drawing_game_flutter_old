import 'package:flutter/material.dart';


class CustomPointSize extends StatelessWidget {

  void Function(double) onTapCallBack;
  Color color;
  double size;

  CustomPointSize({@required this.size, @required this.color, @required this.onTapCallBack});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTapCallBack(size),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: AnimatedContainer(
          duration: new Duration(milliseconds: 150),
          width: size * 2,
          height: size * 2,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(50.0)),
        ),
      ),
    );
  }
}