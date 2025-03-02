import 'package:flutter/material.dart';
import 'dart:math' as math;

// ==============
// Models
// ==============

math.Random random = math.Random();

class Tile {
  Color color;
  int places;
  int index;
  bool select;

  Tile(this.color, this.places, this.index, this.select);

  factory Tile.configTile(int index) {
    return Tile(
      Color.fromARGB(
          255, random.nextInt(255), random.nextInt(255), random.nextInt(255)),
      index + 1,
      index,
      false,
    );
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
    return Container(
      height: 150,
      width: 150,
      color: tile.color,
      padding: EdgeInsets.all(0.0),
      child: Center(
        child: Text(
          'Index: ${tile.index}\nPlace: ${tile.places}\nSelected: ${tile.select}',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: PositionedTiles()));

class PositionedTiles extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PositionedTilesState();
}

class PositionedTilesState extends State<PositionedTiles> {
  int selectedTile = -1;
  int voisinSelected=-1;
  List voisin=[];
  List<Tile> tileData = List.generate(16, (index) => Tile.configTile(index));
  late List<Widget> tiles;

  @override
  void initState() {
    super.initState();
    tiles = tileData.map((tile) => TileWidget(tile)).toList();
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Moving Tiles'),
      centerTitle: true,
    ),
    body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, 
          crossAxisSpacing: 10.0, 
          mainAxisSpacing: 10.0, 
        ),
        itemCount: tileData.length,
        itemBuilder: (context, index) {
          final tile = tileData[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                if (selectedTile == -1) {
                  selectedTile = index;
                  tile.select = !tile.select;
                } else {
                  voisinSelected = index;
                  tile.select = !tile.select;
                  swapTiles(selectedTile, voisinSelected);
                }
              });
              print('Tile tapped! Index: ${tile.index}');
            },
            child: TileWidget(tile),
          );
        },
      ),
    ),
  );
}


  void swapTiles(int i, int j) {
    setState(() {
      if (tileData.length > 1) {
        final temp = tileData[0];
        tileData[0] = tileData[1];
        tileData[1] = temp;
        tiles = tileData.map((tile) => TileWidget(tile)).toList();
      }
      selectedTile = -1;
      voisinSelected=-1;
    });
  }
}
