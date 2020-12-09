import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:flutter_simon/game_cubit.dart';
import 'package:google_fonts/google_fonts.dart';

class CenterConsole extends StatefulWidget {
  @override
  _CenterConsoleState createState() => _CenterConsoleState();
}

class _CenterConsoleState extends State<CenterConsole> {
  double difficulty = 1;

  @override
  Widget build(BuildContext context) {
    return CubitBuilder<GameCubit, GameState>(
      builder: (context, state) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Simon",
                style: GoogleFonts.titilliumWeb(
                  fontWeight: FontWeight.w900,
                  fontSize: 32.0,
                  letterSpacing: 1.25,
                ),
              ),
              IconButton(
                onPressed: () => state.gameInProgress
                    ? context.cubit<GameCubit>().powerOff()
                    : context
                        .cubit<GameCubit>()
                        .initializeGame(difficulty.floor()),
                icon: Icon(
                  Icons.power_settings_new,
                  color: state.gameInProgress ? Colors.blue : Colors.grey,
                ),
              ),
              SizedBox(
                width: 150,
                child: Column(
                  children: [
                    Text(
                      "Difficulty",
                      style: TextStyle(
                        fontSize: 10.0,
                      ),
                    ),
                    Slider(
                      onChanged: !state.gameInProgress
                          ? (v) {
                              setState(() {
                                difficulty = v;
                              });
                            }
                          : null,
                      min: 1,
                      max: 4,
                      divisions: 3,
                      value: difficulty,
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
