import 'package:drawing_game_final/styles/ColorStyles.dart';
import 'package:drawing_game_final/styles/TextStyles.dart';
import 'package:flutter/material.dart';

class CustomBoardTool extends StatelessWidget {

  Widget child;
  String title;
  String backgroundImageName;

  CustomBoardTool({@required this.child, @required this.title, @required this.backgroundImageName});

  @override
  Widget build(BuildContext context) {

    final _size = MediaQuery.of(context).size;

    return Container(
      width: _size.width - (_size.width * 0.05), 
      height: _size.height * 0.2, 
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: ColorStyles.ContainerBackground
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: TextStyles.BoardSettingsTitle),
          SizedBox(height: _size.height * 0.015),
          this.child
        ],
      ),
    );
  }
}