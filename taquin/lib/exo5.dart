import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:taquin/main.dart';

class Exo5a extends StatefulWidget {
  const Exo5a({super.key});

  @override
  State<Exo5a> createState() => _Exo5aState();
}

class _Exo5aState extends State<Exo5a> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exo5a"),
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
                    crossAxisCount: 4,
                    children: [
                      for (var i = 0; i < 16; i++)
                        Container(
                            color: Color((math.Random().nextDouble() * 0xFFFFFF)
                                    .toInt())
                                .withValues(alpha: 1.0),
                            child: Center(
                              child: Text((i % 4).toString() +
                                  " " +
                                  (i ~/ 4).toString()),
                            ))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Exo5b extends StatefulWidget {
  const Exo5b({super.key});

  @override
  State<Exo5b> createState() => _Exo5bState();
}

class _Exo5bState extends State<Exo5b> {
  int n = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exo5b"),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Exo5c extends StatefulWidget {
  const Exo5c({super.key});

  @override
  State<Exo5c> createState() => _Exo5cState();
}

class _Exo5cState extends State<Exo5c> {
  int n = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exo5b"),
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
              Slider(
                divisions: 30,
                value: n.toDouble(),
                min: 2,
                max: 25,
                onChanged: (value) {
                  setState(() {
                    n = value.toInt();
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
