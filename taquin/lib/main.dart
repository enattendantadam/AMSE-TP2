import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MyApp());
}

Tile tile =
    new Tile(imageURL: 'https://picsum.photos/512', alignment: Alignment(0, 0));

class Tile {
  String imageURL;
  Alignment alignment;

  Tile({required this.imageURL, required this.alignment});

  Widget croppedImageTile() {
    return FittedBox(
      fit: BoxFit.fill,
      child: ClipRect(
        child: Container(
          child: Align(
            alignment: this.alignment,
            widthFactor: 0.3,
            heightFactor: 0.3,
            child: Image.network(this.imageURL),
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
        centerTitle: true,
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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Exo5a"),
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
