import 'dart:math';
import 'package:drawing_game_final/custom_widgets/ColorPicker.dart';
import 'package:drawing_game_final/custom_widgets/CustomBoardSetting.dart';
import 'package:drawing_game_final/custom_widgets/CustomPainter.dart';
import 'package:drawing_game_final/drawing_utils/BoardSettings.dart';
import 'package:drawing_game_final/drawing_utils/BrushSize.dart';
import 'package:drawing_game_final/styles/ColorStyles.dart';
import 'package:drawing_game_final/styles/TextStyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class GamePage extends StatelessWidget {

  ScrollController _scrollController = new ScrollController();
  final double LIMITOFFSET = 10;
  bool canChangeTools = false;
  int initialWord = 0;

  final List<String> words = [
    'CARRO',
    'PERRO',
    'GATO',
    'CAMIÓN'
  ];

  GamePage(){
    _scrollController = new ScrollController();
    canChangeTools = true;
    initialWord = Random().nextInt(words.length - 1);
  }


  @override
  Widget build(BuildContext context) {

    final _size = MediaQuery.of(context).size;
    final _boardSettings = Provider.of<BoardSettings>(context);
    
    List<Widget> _boardTools = [
      
      CustomBoardTool(
        title: 'Selecciona el color del pincel:',
        backgroundImageName: 'boxBg1',
        child: ColorPicker(_size.width - (_size.width * 0.15), _size.height),
      ),
      CustomBoardTool(
        title: 'Selecciona el grosor del pincel:',
        backgroundImageName: 'boxBg1',
        child: BrushSize()
      ),
      CustomBoardTool(
        title: 'Selecciona el borrador:',
        backgroundImageName: 'boxBg1',
        child: GestureDetector(
          onTap: () => _boardSettings.isErasing = !_boardSettings.isErasing,
          child: Image.asset('assets/images/eraser.png', width: _size.width * 0.1, height: _size.height * 0.04, fit: BoxFit.contain)
        )
      ),
    ];

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: _size.height * 0.0001),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: _size.height * 0.15,
              width: _size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Dibuja un...', style: TextStyles.Subtitle),
                  Text(words[initialWord], style: TextStyles.TitleWithColor, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            DrawBoard(
              height: _size.height * 0.6, 
              width: _size.width * 0.9, 
              offset: Offset(_size.height * 0.15, 0), 
            ),
            SizedBox(height: _size.height * 0.03),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: _size.width * 0.025),
              child: Row(
                children: [
                  Text('Herramientas de dibujo', style: TextStyles.Subtitle),
                  Spacer(),
                  GestureDetector(
                    child: Icon(Icons.arrow_forward_ios_rounded, color: ColorStyles.Accent),
                    onTap: (){
                      if(canChangeTools){
                        double currentPosition = _scrollController.offset;
                        final double limitPosition = _scrollController.position.maxScrollExtent;
                        final bool isInLimit = limitPosition - currentPosition < LIMITOFFSET;
                        canChangeTools = false;
                        if(isInLimit)
                          _scrollController.animateTo(0, duration: new Duration(milliseconds: 200), curve: Curves.fastOutSlowIn).then((value) => canChangeTools = true);
                        else 
                          _scrollController.animateTo(currentPosition + (_size.width - (_size.width * 0.05)), duration: new Duration(milliseconds: 200), curve: Curves.fastOutSlowIn).then((value) => canChangeTools = true);
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: _size.height * 0.01),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: _size.width * 0.025),
              child: Container(
                height: _size.height * 0.15,
                width: _size.width,
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: _boardTools.length,
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: false,
                  itemBuilder: (_, x){
                    return _boardTools[x];
                  },
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}