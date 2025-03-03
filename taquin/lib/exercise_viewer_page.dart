import 'package:flutter/material.dart';
import 'package:taquin/exo1.dart';
import 'package:taquin/exo2.dart';
import 'package:taquin/exo5.dart';
import 'package:taquin/exo7.dart';
import 'package:taquin/exo_6.dart';
import 'package:taquin/main.dart';

class ExerciseViewerPage extends StatelessWidget {
  const ExerciseViewerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exo3"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    title: Text("exo1"),
                    subtitle: Text("explication exo1"),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Exo1()));
                    },
                  ),
                  ListTile(
                    title: Text("exo2"),
                    subtitle: Text("explication exo2"),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Exo2()));
                    },
                  ),
                  ListTile(
                    title: Text("exo4"),
                    subtitle: Text("explication exo4"),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DisplayTileWidget()));
                    },
                  ),
                  ListTile(
                    title: Text("exo5a"),
                    subtitle: Text("explication exo5a"),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Exo5a()));
                    },
                  ),
                  ListTile(
                    title: Text("exo5b"),
                    subtitle: Text("explication exo5b"),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Exo5b()));
                    },
                  ),
                  ListTile(
                    title: Text("exo5c"),
                    subtitle: Text("explication exo5c"),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Exo5c()));
                    },
                  ),
                  ListTile(
                    title: Text("exo6"),
                    subtitle: Text("explication exo5c"),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PositionedTiles()));
                    },
                  ),
                  ListTile(
                    title: Text("exo7"),
                    subtitle: Text("explication exo7"),
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
