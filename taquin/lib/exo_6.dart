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
  List<List<int>> matrice = [];
  List<int> voisin =[];
  List<Tile> tileData = List.generate(16, (index) => Tile.configTile(index));
  late List<Widget> tiles;

  @override
  void initState() {
    super.initState();
    //tiles = tileData.map((tile) => TileWidget(tile)).toList();
    matrice = List.generate(4, (i) => List.generate(4, (j) => i * 4 + j+1));
    print(matrice);
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
                  voisin =findVoisins(index+1);

                } else {
                  if(isVoisin(index)==true){
                    voisinSelected = index;
                    tile.select = !tile.select;
                    swapTiles(selectedTile, voisinSelected);
                  }
                  else{
                    print("vous ne pouvez pas permuttez ces deux tuiles");
                  }
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

  List<int> findVoisins(int index) {
    int row = index ~/ 4; 
    int col = index % 4;
    List<int> voisins = [];
    if (row > 0) voisins.add(matrice[row - 1][col]); 
    if (row < 3) voisins.add(matrice[row + 1][col]);
    if (col > 0) voisins.add(matrice[row][col - 1]); 
    if (col < 3) voisins.add(matrice[row][col + 1]); 
    return voisins;
  }

  bool isVoisin(int i){
    for(int e in voisin){
      if(e==i){
        return true;
      }
    }
    return false;
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
