import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:taquin/exercise_viewer_page.dart';
import 'exo_6.dart';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

Tile tile = new Tile(
    image: Image.network('https://picsum.photos/512'),
    alignment: Alignment(0.1, 0.1));

class Tile {
  Image image;
  Alignment alignment;
  double widthFactor;
  double heightFactor;

  Tile(
      {required this.image,
      required this.alignment,
      this.heightFactor = 0.3,
      this.widthFactor = 0.3});

  Widget croppedImageTile() {
    return FittedBox(
      fit: BoxFit.fill,
      child: ClipRect(
        child: Container(
          color: Colors.black12,
          child: Align(
            alignment: this.alignment,
            widthFactor: widthFactor,
            heightFactor: heightFactor,
            child: image,
          ),
        ),
      ),
    );
  }
}

class DisplayTileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercice 4'),
      ),
      body: Center(
          child: Column(children: [
        SizedBox(
            width: 150.0,
            height: 150.0,
            child: Container(
                margin: EdgeInsets.all(20.0),
                child: this.createTileWidgetFrom(tile))),
        Container(
            height: 200,
            child:
                Image.network('https://picsum.photos/512', fit: BoxFit.cover))
      ])),
    );
  }

  Widget createTileWidgetFrom(Tile tile) {
    return InkWell(
      child: tile.croppedImageTile(),
      onTap: () {
        print("tapped on tile");
      },
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Color color = const Color.fromARGB(255, 47, 186, 255);
    Color inv = const Color.fromARGB(255, 83, 200, 255);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: color).copyWith(
          inversePrimary: inv, // Enforce your will
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: color,
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 30),
          centerTitle: true,
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: color,
        ),
      ),
      home: const ExerciseViewerPage(),
    );
  }
}
