import 'package:flutter/material.dart';

import 'ColorStyles.dart';

class TextStyles{


  static final TitleWithColor = new TextStyle(
    color: ColorStyles.Accent,
    fontWeight: FontWeight.w900,
    fontSize: 40,
    fontFamily: 'Nova',
  );

  static final Title = new TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w900,
    fontSize: 40,
    fontFamily: 'Nova'
  );

  static final InformationContainerTitle = new TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w900,
    fontSize: 30,
    fontFamily: 'Nova',
  );

  static final Subtitle = new TextStyle(
    color: ColorStyles.BodyText,
    fontWeight: FontWeight.w600,
    fontSize: 23,
    fontFamily: 'Nova'
  );

  static final BoardSettingsTitle = new TextStyle(
    color: ColorStyles.BodyText,
    fontWeight: FontWeight.w500,
    fontSize: 16,
    fontFamily: 'Nova'
  );

  static final InformationContainerBody = new TextStyle(
    color: ColorStyles.BodyText,
    fontWeight: FontWeight.w200,
    fontSize: 18,
    fontFamily: 'Nova'
  );
}