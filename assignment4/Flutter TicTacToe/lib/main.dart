import 'package:calc/screens/tictactoe.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      home: SafeArea(child: Game()),
    ),
  );
}
