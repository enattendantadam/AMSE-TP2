
import 'package:flutter/material.dart';
import 'dart:math' as math;

// ==============
// Models
// ==============

math.Random random = new math.Random();

class Tile {
  Color color = Colors.blue;
  int places =0;
  int index =0;
  bool select=false;

  Tile(
    this.color,
    this.places,
    this.index,
    this.select,
    );
  Tile.getIndex(){
    this.index=index;
    index+=1;
  }
  Tile.randomColor() {
    this.color = Color.fromARGB(
        255, random.nextInt(255), random.nextInt(255), random.nextInt(255));
  }
}

// ==============
// Widgets
// ==============

class TileWidget extends StatelessWidget {
  final Tile tile;

  TileWidget(this.tile);

  @override
  Widget build(BuildContext context) {
    return this.coloredBox();
  }

  Widget coloredBox() {
    return Container(
      color: tile.color,
      child: Padding(
        padding: EdgeInsets.all(70.0),
      )
    );
  }
}

void main() => runApp(new MaterialApp(home: PositionedTiles()));

class PositionedTiles extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PositionedTilesState();
}

class PositionedTilesState extends State<PositionedTiles> {

  List<Widget> tiles =
      List<Widget>.generate(4, (index) => TileWidget(Tile.randomColor()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Moving Tiles'),
        centerTitle: true,
      ),
      body: Row(
        children: tiles.map((e) {
          return GestureDetector(
            onTap: () {
              swapTiles();
              print('Tile tapped!');
            },
            child: e,
          );
        }).toList(),
      ),
      

      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.sentiment_very_satisfied), onPressed: swapTiles),
    );
  }



  swapTiles() {
    setState(() {
      tiles.insert(1, tiles.removeAt(0));
    });
  }
}