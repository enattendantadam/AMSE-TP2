import 'package:flutter/material.dart';
import 'package:taquin/exo1.dart';
import 'package:taquin/exo2.dart';
import 'package:taquin/exo5.dart';
import 'package:taquin/exo7.dart';
import 'package:taquin/exo_6.dart' as exo6;
import 'package:taquin/main.dart';

bool colorshift = true;

bool colorShift() {
  colorshift = !colorshift;
  return colorshift;
}

class ExerciseViewerPage extends StatelessWidget {
  const ExerciseViewerPage({super.key});

  @override
  Widget build(BuildContext context) {
    Color color1 = Color.fromARGB(125, 196, 232, 255);
    Color color2 = Color.fromARGB(132, 156, 213, 249);
    return Scaffold(
      appBar: AppBar(
        title: Text("Exercice 3"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    tileColor: colorShift() ? color1 : color2,
                    title: Text("Exercice 1"),
                    subtitle: Text(
                        "afficher une image venant d'internet sur une page"),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Exo1()));
                    },
                  ),
                  ListTile(
                    tileColor: colorShift() ? color1 : color2,
                    title: Text("Exercice 2"),
                    subtitle: Text(
                        "afficher et modifier (rotation/mirror) une image venant d'internet"),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Exo2()));
                    },
                  ),
                  ListTile(
                    tileColor: colorShift() ? color1 : color2,
                    title: Text("Exercice 4"),
                    subtitle: Text(
                        "afficher une image et une partie cropped de cette image"),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DisplayTileWidget()));
                    },
                  ),
                  ListTile(
                    tileColor: colorShift() ? color1 : color2,
                    title: Text("Exercice 5a"),
                    subtitle:
                        Text("page avec une gridview de différentes cases "),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Exo5a()));
                    },
                  ),
                  ListTile(
                    tileColor: colorShift() ? color1 : color2,
                    title: Text("Exercice 5b"),
                    subtitle: Text(
                        "Afficher une image en la divisant en case de gridview"),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Exo5b()));
                    },
                  ),
                  ListTile(
                    tileColor: colorShift() ? color1 : color2,
                    title: Text("Exercice 5c"),
                    subtitle: Text(
                        "Afficher une image en la divisant en case de gridview ave un slider pour modifier la taille de la gridview"),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Exo5c()));
                    },
                  ),
                  ListTile(
                    tileColor: colorShift() ? color1 : color2,
                    title: Text("Exercice 6"),
                    subtitle: Text("logique du jeu du taquin"),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => exo6.PositionedTiles()));
                    },
                  ),
                  ListTile(
                    tileColor: colorShift() ? color1 : color2,
                    title: Text("Exercice 7"),
                    subtitle: Text("taquin fonctionnel"),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Exo7()));
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
