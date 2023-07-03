import 'package:drawing_game_final/styles/ColorStyles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'BoardSettings.dart';

class BrushSize extends StatefulWidget {
  @override
  _BrushSizeState createState() => _BrushSizeState();
}

class _BrushSizeState extends State<BrushSize> {
  @override
  Widget build(BuildContext context) {

    final _boardSettings = Provider.of<BoardSettings>(context);
    final _size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Stack(
          alignment: Alignment.center,
          fit: StackFit.loose,
          overflow: Overflow.visible,
          children: [
            Slider(
              activeColor: _boardSettings.brushColor,
              inactiveColor: ColorStyles.Accent.withOpacity(0.5),
              onChanged: (double value) => setState(() => _boardSettings.brushSize = value),
              value: _boardSettings.brushSize,
              min: 0.01,
              max: 0.05,
            ),
            Positioned(
              top: (_size.height * 0.06) - ((_size.height * _boardSettings.brushSize) / 2),
              left: (_size.width * 0.48) - ((_size.width * _boardSettings.brushSize) / 2),
              child: Container(
                width: _size.width * _boardSettings.brushSize,
                height: _size.height * _boardSettings.brushSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _boardSettings.brushColor
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}