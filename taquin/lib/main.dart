import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
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
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListView(
              children: [
                ListTile(
                  title: Text("exo1"),
                  subtitle: Text("explication exo1"),
                )
              ],
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
            Transform(
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
