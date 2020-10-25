import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  bool isX = true;
  bool isGamePlaying = true;
  var text = '';
  String resultString = '';
  int counter = 0;

  /*
  1. After setting row and column first thing I need to see is that whether a pressed button has X 0 or empty value
  2. To distinguish every button we must pass their position so consider the layout as a 3x3 matrix where each index is a button
  3. Now create a matrix of Strings where the value will or text of buttons will be stored therefore it will map to matrix of buttons

  */
  var grid;

  _initializeGrid() {
    grid = [
      ['', '', ''],
      ['', '', ''],
      ['', '', '']
    ];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializeGrid();
  }

  var buttons = [
    {'row': 0, 'col': 0},
    {'row': 0, 'col': 1},
    {'row': 0, 'col': 2},
    {'row': 1, 'col': 0},
    {'row': 1, 'col': 1},
    {'row': 1, 'col': 2},
    {'row': 2, 'col': 0},
    {'row': 2, 'col': 1},
    {'row': 2, 'col': 2},
  ];

  bool isBlank(pos) {
    var map = buttons[pos];
    bool result = grid[map['row']][map['col']] == '';
    return result;
  }

  bool checkAllThree(first, second, third) {
    bool result3 = !isBlank(first) && !isBlank(second) && !isBlank(third);
    return result3;
  }

  bool checkResult(first, second, third) {
    if (checkAllThree(first, second, third)) {
      //this checks blank
      int row1 = buttons[first]['row'];
      int col1 = buttons[first]['col'];

      int row2 = buttons[second]['row'];
      int col2 = buttons[second]['col'];

      int row3 = buttons[third]['row'];
      int col3 = buttons[third]['col'];

      if ((grid[row1][col1] == grid[row2][col2]) &&
          (grid[row2][col2] == grid[row3][col3])) {
        return true;
      }
    }
    return false;
  }

  bool checkGameOver() {
    return checkResult(0, 1, 2) ||
        checkResult(3, 4, 5) ||
        checkResult(6, 7, 8) ||
        checkResult(0, 3, 6) ||
        checkResult(1, 4, 7) ||
        checkResult(2, 5, 8) ||
        checkResult(0, 4, 8) ||
        checkResult(2, 4, 6);
  }

  _makeRow(int rowNumber) {
    return Container(
      child: Row(
        children: [
          _makeButton(rowNumber, 0),
          _makeButton(rowNumber, 1),
          _makeButton(rowNumber, 2)
        ],
      ),
    );
  }

  _makeButton(int row, int col) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(10),
        color: Colors.blue[200],
        width: 100,
        height: 100,
        child: Center(
          child: FlatButton(
            onPressed: () {
              //print('Row: $row Col: $col');
              setState(() {
                if (grid[row][col] == '' && isGamePlaying) {
                  if (isX) {
                    grid[row][col] = 'X';
                  } else {
                    grid[row][col] = '0';
                  }
                  print(grid);
                  counter++;

                  if (counter > 4) {
                    if (checkGameOver()) {
                      setState(() {
                        resultString = isX ? '✨X Wins' : '✨0 Wins';
                        isGamePlaying = false;
                        // grid.forEach((element) {
                        //   element.forEach((element) {
                        //     element = '';
                        //   });
                        // });
                      });
                    } else if (counter >= 9) {
                      setState(() {
                        resultString = 'No one wins 😔';
                        isGamePlaying = false;
                      });
                    }
                  }

                  isX = !isX;
                }
              });
            },
            child: Text(
              grid[row][col],
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
          ),
        ),
      ),
    );
  } //_getButton() ends here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              _makeRow(0),
              _makeRow(1),
              _makeRow(2),
              Container(
                margin: EdgeInsets.only(top: 30, bottom: 30),
                child: Text(
                  resultString,
                  style: TextStyle(fontSize: 30, color: Colors.amberAccent),
                ),
              ),
              Container(
                child: OutlineButton(
                  child: Text(
                    'New Game',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    setState(() {
                      grid.clear();
                      _initializeGrid();
                      counter = 0;
                      isX = true;
                      isGamePlaying = true;
                      resultString = '';
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
