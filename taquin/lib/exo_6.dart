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
  bool selected=false;

  Tile(this.color, this.places, this.index, this.selected);

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
  final bool isVoisin;

  TileWidget(
    this.tile,
    this.isVoisin,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 150,
      padding: EdgeInsets.all(0.0),
      decoration: BoxDecoration(
        color: tile.selected ? tile.color.withOpacity(0.5) : tile.color,
        border: Border.all(
          color: isVoisin ? Colors.red : Colors.transparent,
          width: 5.0,
        ),
      ),
      /*
      child: Center(
        child: Text(
          'Index: ${tile.index}\nPlace: ${tile.places}\nSelected: ${tile.select}',
          style: TextStyle(color: Colors.white),
        ),
      ),
      */
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
    tiles = tileData.map((tile) => TileWidget(tile,false)).toList();
    matrice = List.generate(4, (i) => List.generate(4, (j) => i * 4 + j+1));
    //print(matrice);
    //print (matrice[0][3]);
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
          final bool isVoisin = voisin.contains(index);
          final tile = tileData[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                if (selectedTile == -1) {
                  selectedTile = index;
                  tileData[index].selected = true;
                  voisin =findVoisins(index);
                } else {
                  if(estVoisin(index)==true){
                    voisinSelected = index;
                    swapTiles(selectedTile, voisinSelected);
                  }
                  else{
                    print("vous ne pouvez pas permuttez ces deux tuiles");
                  }
                }
              });
              print('Tile tapped! Index: ${tile.index}');
            },
            onDoubleTap: () {
              setState(() {
                selectedTile = index;
                tileData[index].selected = true;
                voisin = findVoisins(index);
                print('Double tap détecté! Voisins: $voisin');
              });
            },
            child: TileWidget(tile,isVoisin),
          );
        },
      ),
    ),
  );
}

  List<int> findVoisins(int index) {
    int row = (index) ~/ 4; 
    int col = ((index) % 4);
    List<int> voisins = [];
    if (row > 0) voisins.add(matrice[row - 1][col]-1); // -1 parce qu'on veut les index
    if (row < 3) voisins.add(matrice[row + 1][col]-1);
    if (col > 0) voisins.add(matrice[row][col - 1]-1); 
    if (col < 3) voisins.add(matrice[row][col + 1]-1); 
    return voisins;
  }

  bool estVoisin(int i){
    for(int e in voisin){
      if(e==i){
        return true;
      }
    }
    return false;
  }

  void swapTiles(int i, int j) {
    setState(() {
      if (tileData.length > 1 && i >= 0 && j >= 0 && i < tileData.length && j < tileData.length) {
        final temp = tileData[i];
        tileData[i] = tileData[j];
        tileData[j] = temp;
        tileData.forEach((tile) => tile.selected = false);
        tileData[j].selected=true;
        selectedTile = j;
        voisin = findVoisins(j);
        tiles = tileData.map((tile) => TileWidget(tile,false)).toList();
      }
    });
  }
}
