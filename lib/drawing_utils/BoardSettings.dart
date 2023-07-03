import 'package:flutter/material.dart';

class BoardSettings with ChangeNotifier{

  Color _boardColor = Colors.white;
  Color _brushColor = Colors.black;
  double _brushSize = 5;
  bool _isErasing = false;

  set boardColor(Color color){
    _boardColor = color;
    notifyListeners();
  }

  set brushColor(Color color){
    _brushColor = color;
    notifyListeners();
  }

  set brushSize(double size){
    _brushSize = size;
    notifyListeners();
  }

  set isErasing(bool erasing){
    _isErasing = erasing;
    notifyListeners();
  }

  Color get boardColor => _boardColor;
  Color get brushColor => _brushColor;
  double get brushSize => _brushSize;
  bool get isErasing => _isErasing;

  BoardSettings({
    @required Color boardColor,
    @required Color brushColor,
    @required double brushSize,
    @required bool isErasing
  }){
    this._boardColor = boardColor;
    this._brushColor = brushColor;
    this._brushSize = brushSize;
    this._isErasing = isErasing;
  }
  
}