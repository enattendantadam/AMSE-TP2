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
      home: const ExerciseViewerPage(title: 'Flutter Demo Home Page'),
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
              children: [],
            )
          ],
        ),
      ),
    );
  }
}

class ExercisePage extends StatefulWidget {
  const ExercisePage({super.key, required this.title});

  final String title;

  @override
  State<ExercisePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ExercisePage> {
  double _rotateX = 0;
  double _rotateZ = 0;
  double _scalefactor = 1;
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  void _startSound() async {
    if (!_isPlaying) {
      _isPlaying = true;
      await _audioPlayer.play(AssetSource('sound.mp3'));
    }
  }

  // Function to stop sound
  void _stopSound() async {
    if (_isPlaying) {
      _isPlaying = false;
      await _audioPlayer.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the ExercisePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              clipBehavior: Clip.hardEdge,
              width: 400,
              height: 400,
              decoration: BoxDecoration(color: Colors.white),
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
