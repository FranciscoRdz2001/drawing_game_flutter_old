import 'package:flutter/material.dart';

class ColorSliderIndicator extends CustomPainter{
  
  final double position;
  ColorSliderIndicator(this.position);

  @override
  void paint(Canvas canvas, Size size) => canvas.drawCircle(Offset(position, size.height / 2), 12, Paint()..color = Colors.white);
  
  @override
  bool shouldRepaint(ColorSliderIndicator old) => true;
}