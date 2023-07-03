import 'package:drawing_game_final/drawing_utils/BoardSettings.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ColorSliderIndicator.dart';


class ColorPicker extends StatefulWidget {
  
  final double width;
  final double heigh;

  ColorPicker(this.width, this.heigh);

  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {

  BoardSettings _boardSettings = new BoardSettings(boardColor: Colors.white, brushColor: Colors.black, brushSize: 5, isErasing: false);
  final List<Color> _colors = [
    Color.fromARGB(255, 255, 0, 0),
    Color.fromARGB(255, 255, 128, 0),
    Color.fromARGB(255, 255, 255, 0),
    Color.fromARGB(255, 128, 255, 0),
    Color.fromARGB(255, 0, 255, 0),
    Color.fromARGB(255, 0, 255, 128),
    Color.fromARGB(255, 0, 255, 255),
    Color.fromARGB(255, 0, 128, 255),
    Color.fromARGB(255, 0, 0, 255),
    Color.fromARGB(255, 127, 0, 255),
    Color.fromARGB(255, 255, 0, 255),
    Color.fromARGB(255, 255, 0, 127),
    Color.fromARGB(255, 128, 128, 128),
  ];

  double _colorSliderPosition = 0;

  @override
  initState() {
    super.initState();
    _colorSliderPosition = widget.width * 0.5;
  }

  void _colorChangeHandler(double position) {
    if (position > widget.width) position = widget.width;
    if (position < 0) position = 0;
    _colorSliderPosition = position;
    _calculateSelectedColor(_colorSliderPosition);
  }

  void _calculateSelectedColor(double position) {
    //determine color
    double positionInColorArray = (position / widget.width * (_colors.length - 1));
    int index = positionInColorArray.truncate();
    double remainder = positionInColorArray - index;
    if (remainder == 0.0) _boardSettings.brushColor = _colors[index];
    else {
      //calculate new color
      int redValue = _colors[index].red == _colors[index + 1].red
          ? _colors[index].red
          : (_colors[index].red +
                  (_colors[index + 1].red - _colors[index].red) * remainder)
              .round();
      int greenValue = _colors[index].green == _colors[index + 1].green
          ? _colors[index].green
          : (_colors[index].green +
                  (_colors[index + 1].green - _colors[index].green) * remainder)
              .round();
      int blueValue = _colors[index].blue == _colors[index + 1].blue
          ? _colors[index].blue
          : (_colors[index].blue +
                  (_colors[index + 1].blue - _colors[index].blue) * remainder)
              .round();
      _boardSettings.brushColor = Color.fromARGB(255, redValue, greenValue, blueValue);
    }
  }
@override
  Widget build(BuildContext context) {

    _boardSettings = Provider.of<BoardSettings>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: widget.heigh * 0.01),
        GestureDetector(
          onHorizontalDragStart: (DragStartDetails details) => _colorChangeHandler(details.localPosition.dx),
          onHorizontalDragUpdate: (DragUpdateDetails details) => _colorChangeHandler(details.localPosition.dx),
          onTapDown: (TapDownDetails details) => _colorChangeHandler(details.localPosition.dx),
          child: Container(
            width: widget.width,
            height: widget.heigh * 0.02,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              gradient: LinearGradient(colors: _colors),
            ),
            child: CustomPaint(
              painter: ColorSliderIndicator(_colorSliderPosition),
            ),
          ),
        ),
        SizedBox(height: widget.heigh * 0.015),
        AnimatedContainer(
          duration: new Duration(milliseconds: 150),
          height: widget.heigh * 0.04,
          width: widget.width * 0.1,
          decoration: BoxDecoration(
            color: _boardSettings.brushColor,
            borderRadius: BorderRadius.circular(25),
          ),
        )
      ],
    );
  }
}