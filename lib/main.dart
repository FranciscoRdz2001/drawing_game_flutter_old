import 'package:drawing_game_final/screens/GamePage.dart';
import 'package:drawing_game_final/screens/HomePage.dart';
import 'package:drawing_game_final/styles/ColorStyles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'drawing_utils/BoardSettings.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return ChangeNotifierProvider(
      create: (_) => BoardSettings(boardColor: Colors.white, brushColor: Colors.black, brushSize: 0.01, isErasing: false),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: ColorStyles.Background
        ),
        title: 'DrawingGame',
        home: HomePage(),
        routes: {
          'homePage' : (context) => HomePage(),
          'gamePage' : (context) => GamePage()
        },
      ),
    );
  }
}