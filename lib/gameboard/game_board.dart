import 'package:flutter/material.dart';
import 'package:flutter_simon/gameboard/color-button.dart';
import 'package:flutter_simon/gameboard/color-definition.dart';

import 'center_console.dart';

class GameBoard extends StatelessWidget {
  final Map<String, ColorDefinition> _colorDefinitions = {
    'green': new ColorDefinition(Colors.green, 0, Colors.green.shade200, 55),
    'red': new ColorDefinition(Colors.red, 1, Colors.red.shade200, 64),
    'yellow': new ColorDefinition(Colors.yellow, 3, Colors.yellow.shade200, 48),
    'blue': new ColorDefinition(Colors.blue, 2, Colors.blue.shade200, 79),
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.height,
          height: MediaQuery.of(context).size.height,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(500.0),
            child: Container(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: ColorButton(
                                colorDefinition: _colorDefinitions['green'],
                              ),
                            ),
                            Container(
                              width: 12,
                            ),
                            Expanded(
                              child: ColorButton(
                                colorDefinition: _colorDefinitions['red'],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 12,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: ColorButton(
                                colorDefinition: _colorDefinitions['yellow'],
                              ),
                            ),
                            Container(
                              width: 12,
                            ),
                            Expanded(
                              child: ColorButton(
                                colorDefinition: _colorDefinitions['blue'],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.height * 0.25,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(500.0),
                      color: Colors.black,
                    ),
                    child: CenterConsole(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
