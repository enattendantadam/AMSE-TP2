import 'package:flutter/material.dart';

class Exo1 extends StatefulWidget {
  const Exo1({super.key});

  @override
  State<Exo1> createState() => _Exo1State();
}

class _Exo1State extends State<Exo1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exo1"),
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
