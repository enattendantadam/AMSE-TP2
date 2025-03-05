import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class Exo2 extends StatefulWidget {
  const Exo2({super.key});
  @override
  State<Exo2> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Exo2> {
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
      await _audioPlayer.setPlaybackRate(_scalefactor);
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
        title: Text("Exo2"),
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
