import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:taquin/main.dart';

class Exo7 extends StatefulWidget {
  const Exo7({super.key});

  @override
  State<Exo7> createState() => _Exo7State();
}

class _Exo7State extends State<Exo7> {
  int n = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FilledButton(
              style: ButtonStyle(),
              onPressed: () {
                setState(() {
                  n = math.max(2, n - 1);
                });
              },
              child: Text("-"),
            ),
            SizedBox(width: 10.0),
            FilledButton(
              onPressed: () {
                setState(() {
                  n = math.min(25, n + 1);
                });
              },
              child: Text("+"),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Text("Start"),
        onPressed: () {},
        shape: CircleBorder(),
      ),
      appBar: AppBar(
        title: Text("Exo7"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  width: 500,
                  child: GridView.count(
                    crossAxisCount: n,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    children: [
                      for (var i = 0; i < n * n; i++)
                        Tile(
                                image: Image.asset("2.png"),
                                alignment: Alignment(
                                    -1.0 + (2.0 / (n - 1)) * (i % n),
                                    -1.0 + (2.0 / (n - 1)) * (i ~/ n)),
                                widthFactor: 1 / n,
                                heightFactor: 1 / n)
                            .croppedImageTile()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
