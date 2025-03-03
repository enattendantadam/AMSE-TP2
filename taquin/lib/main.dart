import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
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
        title: Text('Display a Tile as a Cropped Image'),
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
    Color color = Colors.blue;
    Color inv = Colors.lightBlue;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: color).copyWith(
          inversePrimary: inv, // Enforce your will
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: color,
          centerTitle: true,
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: color,
        ),
        useMaterial3: true,
      ),
      home: const ExerciseViewerPage(),
    );
  }
}

class ExerciseViewerPage extends StatelessWidget {
  const ExerciseViewerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exo1"),
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

class Exo1 extends StatefulWidget {
  const Exo1({super.key});
  @override
  State<Exo1> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Exo1> {
  double _rotateX = 0;
  double _rotateZ = 0;
  double _scalefactor = 1;
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  bool _isChecked = false;

  void _startSound() async {
    if (!_isPlaying) {
      _isPlaying = true;
      await _audioPlayer.setReleaseMode(ReleaseMode.loop);
      await _audioPlayer
          .setVolume((_rotateX * _rotateZ) / (3.141 * 2 * 3.141 * 2));
      await _audioPlayer.setPlaybackRate(_scalefactor); // Apply pitch change
      await _audioPlayer.play(AssetSource('slider_sound.mp3'));
    }
  }

  // Function to stop sound
  void _stopSound() async {
    if (_isPlaying) {
      _isPlaying = false;
      await _audioPlayer.stop();
    }
  }

  void _onCheckboxChanged(bool? value) {
    setState(() {
      _isChecked = value ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exo1"),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Transform.flip(
              flipX: _isChecked,
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..rotateX(_rotateX)
                  ..rotateZ(_rotateZ)
                  ..scale(_scalefactor),
                child: Image.network(
                  "https://picsum.photos/512/1024",
                  width: 200,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text("Rotate X"),
            Slider(
              value: _rotateX,
              min: 0,
              max: 3.141 * 2,
              onChangeStart: (_) => _startSound(),
              onChanged: (value) {
                setState(() {
                  _rotateX = value;
                });
              },
              onChangeEnd: (_) => _stopSound(),
            ),
            Text("Rotate Z"),
            Slider(
              value: _rotateZ,
              min: 0,
              max: 3.141 * 2,
              onChangeStart: (_) => _startSound(),
              onChanged: (value) {
                setState(() {
                  _rotateZ = value;
                });
              },
              onChangeEnd: (_) => _stopSound(),
            ),
            Text("Mirror"),
            Checkbox(value: _isChecked, onChanged: _onCheckboxChanged),
            Text("Scale"),
            Slider(
              value: _scalefactor,
              min: 0,
              max: 3.141 * 2,
              onChangeStart: (_) => _startSound(),
              onChanged: (value) {
                setState(() {
                  _scalefactor = value;
                });
              },
              onChangeEnd: (_) => _stopSound(),
            ),
          ],
        ),
      ),
    );
  }
}

class Exo2 extends StatefulWidget {
  const Exo2({super.key});

  @override
  State<Exo2> createState() => _Exo2State();
}

class _Exo2State extends State<Exo2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exo2"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(
              "https://picsum.photos/512/1024",
              width: 200,
            ),
          ],
        ),
      ),
    );
  }
}

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
      body: Center(
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
                          child: Text(
                              (-1.0 + (2.0 / (3)) * (i % 4)).toString() +
                                  " " +
                                  (-1.0 + (2.0 / (3)) * (i ~/ 4)).toString()))
                  ],
                ),
              ),
            )
          ],
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
