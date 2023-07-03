
import 'package:drawing_game_final/styles/ColorStyles.dart';
import 'package:drawing_game_final/styles/TextStyles.dart';
import 'package:flutter/material.dart';


class InformationContainer extends StatelessWidget {

  String title;
  String subTitle;
  double height;
  double width;

  InformationContainer({@required this.subTitle, @required this.title, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: ColorStyles.ContainerBackground,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: TextStyles.InformationContainerTitle, textAlign: TextAlign.center),
          Text(subTitle, style: TextStyles.InformationContainerBody, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}