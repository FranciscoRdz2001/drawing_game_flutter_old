import 'dart:ui';
import 'package:drawing_game_final/drawing_utils/BoardSettings.dart';
import 'package:drawing_game_final/styles/ColorStyles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class DrawBoard extends StatefulWidget{

  double height;
  double width;
  Offset offset;

  DrawBoard({@required this.height, @required this.width, @required this.offset});

  @override
  _DrawBoardState createState() => _DrawBoardState();
}

class _DrawBoardState extends State<DrawBoard> {

  List<_PointsInBoard> points = [];
  List<Offset> pointsOffsets = [];
  List<Offset> pointsToErase = [];
  BoardSettings boardSettings = new BoardSettings(boardColor: Colors.white, brushColor: Colors.black, brushSize: 5, isErasing: false);
  int nullPoints = 0;

  @override
  void initState() {
    super.initState();
    _clearBoard();
  }

  void _clearBoard(){
    print('board clear');
    setState(() {
      points = [];
      pointsOffsets = [];
      pointsToErase = [];
      nullPoints = 0;
    });
  }


  void createPointInBoard(Offset position){
    if(position.dx > widget.width + widget.offset.dy || position.dy > widget.height + widget.offset.dx || position.dy < widget.offset.dx) return;
    if(boardSettings.isErasing && points.length > 0 && pointsToErase.length > 0){
        for(int x = 0; x < pointsToErase.length; x++){
          for(int i = 0; i < points.length; i++){
            if(points[i] == null) continue;
            final dif = points[i].points - pointsToErase[x];
            if(dif.distance < 20){
              points[i] = null;
              nullPoints += 1;
            }
          }
          pointsToErase.remove(pointsToErase[x]);
          if(nullPoints == points.length) _clearBoard();
        }
      }

    if(boardSettings.isErasing) setState(() => pointsToErase.add(new Offset((position.dx + widget.offset.dy), (position.dy - widget.offset.dx))));
    else{
      print(widget.offset);
      points.add(
        new _PointsInBoard(
          points: new Offset((position.dx + widget.offset.dy), (position.dy - widget.offset.dx)),
          paint: new Paint()..color = boardSettings.brushColor
                            ..strokeWidth = widget.width * boardSettings.brushSize
                            ..strokeCap = StrokeCap.round, 
        )
      );
      setState(() => pointsOffsets.add(points[points.length - 1].points));
    }
  }

  @override
  Widget build(BuildContext context) {

    boardSettings = Provider.of<BoardSettings>(context);

    return Container(
      height: this.widget.height,
      width: this.widget.width,
      decoration: BoxDecoration(
        color: ColorStyles.BoardBackground,
        borderRadius: BorderRadius.circular(10)
      ),
      child: GestureDetector(
        onLongPress: () => _clearBoard(),
        onPanStart: (details) => createPointInBoard(details.globalPosition),
        onPanUpdate: (details) => createPointInBoard(details.globalPosition),
        onPanEnd: (_) {
          nullPoints += 1;
          points.add(null);
        },
        child: CustomPaint(
          size: new Size(widget.width, widget.height),
          painter: _BoardPainter(
            isErasing: boardSettings.isErasing,
            points: this.points, 
            pointsOffsets: this.pointsOffsets, 
            pointsToErase: this.pointsToErase
          ),
        ),
      )
    );
  }
}

class _BoardPainter extends CustomPainter{
  
  List<_PointsInBoard> points;
  List<Offset> pointsOffsets;
  List<Offset> pointsToErase;
  Color color = Colors.black;
  bool isErasing;

  _BoardPainter({@required this.points, @required this.pointsOffsets, @required this.isErasing, @required this.pointsToErase});

  @override
  void paint(Canvas canvas, Size size) {
    if(points != []){
      for(int x = 0; x < points.length - 1; x++){
      if(points[x] != null && points[x + 1] != null) canvas.drawLine(points[x].points, points[x + 1].points, points[x].paint);
      else if(points[x] != null && points[x + 1] == null)
        canvas.drawPoints(PointMode.polygon, [points[x].points, Offset(points[x].points.dx + 0.1, points[x].points.dy + 0.1)], points[x].paint);
      } 
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class _PointsInBoard{

  Offset points;
  Paint paint;

  _PointsInBoard({@required this.paint, @required this.points});

}

