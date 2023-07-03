import 'package:drawing_game_final/custom_widgets/InformationContainer.dart';
import 'package:drawing_game_final/styles/ColorStyles.dart';
import 'package:drawing_game_final/styles/TextStyles.dart';
import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  

  List<InformationContainer> information = [
    
    InformationContainer(
      subTitle: 'Nivel',
      title: '5',
    ),
    InformationContainer(
      subTitle: 'Partidas',
      title: '30',
    ),
    InformationContainer(
      subTitle: 'Victorias',
      title: '5',
    ),
    InformationContainer(
      subTitle: 'Victorias',
      title: '5',
    ),
  ];

  @override
  Widget build(BuildContext context) {

    final _size = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: _size.height * 0.1, left: _size.width * 0.05, right: _size.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Hola ', style: TextStyles.Title),
                Text('Francisco', style: TextStyles.TitleWithColor),
              ],
            ),
            Text('Bienvenido de nuevo', style: TextStyles.Subtitle),
            SizedBox(height: _size.height * 0.025),
            GestureDetector(
              onTap: () => Navigator.of(context).pushNamed('gamePage'),
              child: Container(
                height: _size.height * 0.20,
                width: _size.width * 0.4,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      ColorStyles.Accent,
                      ColorStyles.DarkAccent,
                    ]
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Iniciar juego', style: TextStyles.InformationContainerTitle, textAlign: TextAlign.center),
                    SizedBox(height: _size.height * 0.01),
                    Image.asset('assets/images/colorpallete.png', width: _size.width * 0.2, height: _size.height * 0.1),
                  ],
                ),
              ),
            ),
            SizedBox(height: _size.height * 0.05),
            Text('Mis estadisticas:', style: TextStyles.Subtitle),
            Container(
              height: _size.height * 0.4,
              width: _size.width,
              child: GridView.builder(
                itemCount: information.length,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: _size.height * 0.3,
                  childAspectRatio: 3 / 2,
                  crossAxisSpacing: _size.width * 0.025,
                  mainAxisSpacing: _size.height * 0.02
                ),
                itemBuilder: (_, x){
                  return InformationContainer(
                    subTitle: information[x].subTitle,
                    title: information[x].title,
                    height: _size.height * 0.1,
                    width: _size.width * 0.25,
                  );
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}