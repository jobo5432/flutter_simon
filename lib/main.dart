import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:flutter_simon/game_cubit.dart';
import 'package:flutter_simon/gameboard/game_board.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FLutter Simon',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Theme(
          data: ThemeData.dark(),
          child: MultiCubitProvider(
            providers: [
              CubitProvider<GameCubit>(
                create: (context) => GameCubit(),
              ),
            ],
            child: GameBoard(),
          )),
    );
  }
}
