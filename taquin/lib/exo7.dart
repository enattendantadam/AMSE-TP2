import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:taquin/exo_6.dart' as exo6;
import 'package:taquin/main.dart';

math.Random random = math.Random();

class Exo7 extends StatefulWidget {
  const Exo7({super.key});

  @override
  State<Exo7> createState() => _Exo7State();
}

class _Exo7State extends State<Exo7> {
  int n = 4;
  List<List<Tile>> grid = [[]];
  int selectedX = -1;
  int selectedY = -1;
  bool start = false;
  List<Tile> voisin = [];

  _Exo7State() {
    gen();
  }

  void gen() {
    grid = List.generate(n, (rowIndex) {
      return List.generate(n, (colIndex) {
        return Tile(
          image: Image.asset("2.png"),
          alignment: Alignment(
            -1.0 + (2.0 / (n - 1)) * colIndex,
            -1.0 + (2.0 / (n - 1)) * rowIndex,
          ),
          widthFactor: 1 / n,
          heightFactor: 1 / n,
          index: rowIndex * n + colIndex,
        );
      });
    });
  }

  void select() {
    if (start) {
      start = false;
      gen();
      return;
    }
    start = true;
    selectedX = random.nextInt(n);
    selectedY = random.nextInt(n);
    grid[selectedX][selectedY].selected = true;
    addVoisin(selectedX, selectedY);
  }

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
              onPressed: start
                  ? null
                  : () {
                      setState(() {
                        n = math.max(2, n - 1);
                        gen();
                      });
                    },
              child: Text("-"),
            ),
            SizedBox(width: 10.0),
            FilledButton(
              onPressed: start
                  ? null
                  : () {
                      setState(() {
                        n = math.min(25, n + 1);
                        gen();
                      });
                    },
              child: Text("+"),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Text(start ? "reset" : "start"),
        onPressed: () {
          setState(() {
            select();
          });
        },
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
                        GestureDetector(
                          onTap: !grid[i ~/ n][i % n].voisin
                              ? null
                              : () {
                                  print(grid[i ~/ n][i % n].voisin);
                                  setState(() {
                                    Tile temp = grid[selectedX][selectedY];
                                    grid[selectedX][selectedY] =
                                        grid[i ~/ n][i % n];
                                    grid[i ~/ n][i % n] = temp;
                                    selectedX = i ~/ n;
                                    selectedY = i % n;
                                    addVoisin(selectedX, selectedY);
                                  });
                                },
                          child: grid[i ~/ n][i % n].croppedImageTile(),
                        )
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

  void addVoisin(i, j) {
    for (var i = 0; i < voisin.length; i++) {
      voisin[i].voisin = false;
    }
    voisin = [];
    // Right neighbor
    if (i + 1 < n) {
      voisin.add(grid[i + 1][j]);
      grid[i + 1][j].voisin = true;
    }

    // Down neighbor
    if (j + 1 < n) {
      voisin.add(grid[i][j + 1]);
      grid[i][j + 1].voisin = true;
    }

    // Left neighbor
    if (i - 1 >= 0) {
      voisin.add(grid[i - 1][j]);
      grid[i - 1][j].voisin = true;
    }

    // Up neighbor
    if (j - 1 >= 0) {
      voisin.add(grid[i][j - 1]);
      grid[i][j - 1].voisin = true;
    }
  }
}

class Tile {
  Image image;
  Alignment alignment;
  double widthFactor;
  double heightFactor;
  int index;
  bool selected;
  bool voisin = false;
  Tile({
    required this.image,
    required this.alignment,
    this.widthFactor = 0.3,
    this.heightFactor = 0.3,
    required this.index,
    this.selected = false,
  });

  factory Tile.configTile(int index, Image image) {
    return Tile(
      image: image,
      alignment: Alignment.center,
      index: index,
    );
  }

  Widget croppedImageTile() {
    return FittedBox(
      fit: BoxFit.fill,
      child: ClipRect(
        child: Container(
          color: Colors.black12,
          child: Align(
            alignment: alignment,
            widthFactor: widthFactor,
            heightFactor: heightFactor,
            child: selected ? Container(color: Colors.white) : image,
          ),
        ),
      ),
    );
  }
}

class TileWidget extends StatelessWidget {
  final Tile tile;
  final bool isVoisin;

  TileWidget(this.tile, this.isVoisin);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 150,
      padding: EdgeInsets.all(0.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: isVoisin ? Colors.red : Colors.transparent,
          width: 5.0,
        ),
      ),
      child: tile.croppedImageTile(),
    );
  }
}
