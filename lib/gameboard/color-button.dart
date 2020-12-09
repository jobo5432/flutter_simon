import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:flutter_midi/flutter_midi.dart';
import 'package:flutter_simon/game_cubit.dart';
import 'package:flutter_simon/gameboard/color-definition.dart';

class ColorButton extends StatefulWidget {
  final ColorDefinition colorDefinition;

  ColorButton({Key key, this.colorDefinition}) : super(key: key);

  @override
  _ColorButtonState createState() => _ColorButtonState();
}

class _ColorButtonState extends State<ColorButton> {
  final fm = new FlutterMidi();

  Color currentColor;

  @override
  initState() {
    fm.unmute();
    rootBundle.load("assets/Piano.sf2").then((sf2) {
      fm.prepare(sf2: sf2, name: "Piano.sf2");
    });
    super.initState();
  }

  Timer initColorTimer;

  @override
  Widget build(BuildContext context) {
    return CubitListener<GameCubit, GameState>(
      listener: (context, state) async {
        if (state.gameInitializing) {
          await Future.delayed(
              Duration(milliseconds: 500 * widget.colorDefinition.offset));
          initColorTimer =
              Timer.periodic(Duration(milliseconds: 50), (timer) async {
            setState(() {
              currentColor = widget.colorDefinition.highlightColor;
            });
            await Future.delayed(Duration(milliseconds: 50));
            setState(() {
              currentColor = widget.colorDefinition.color;
            });
          });
        } else {
          initColorTimer?.cancel();
          setState(() {
            currentColor = widget.colorDefinition.color;
          });
        }
      },
      child: CubitBuilder<GameCubit, GameState>(
        builder: (context, state) {
          return GestureDetector(
            onTapDown: !state.gameInProgress
                ? null
                : (_) async {
                    setState(() {
                      currentColor = widget.colorDefinition.highlightColor;
                    });
                    fm.playMidiNote(midi: widget.colorDefinition.note);
                  },
            onTapUp: !state.gameInProgress
                ? null
                : (_) {
                    setState(() {
                      currentColor = widget.colorDefinition.color;
                    });
                    fm.stopMidiNote(midi: widget.colorDefinition.note);
                  },
            child: Container(
              color: state.gameInitializing
                  ? currentColor
                  : !state.gameInProgress
                      ? widget.colorDefinition.color.withAlpha(64)
                      : currentColor,
            ),
          );
        },
      ),
    );
  }
}
