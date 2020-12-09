import 'package:cubit/cubit.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit() : super(GameState.gameOff());

  Future<GameState> initializeGame(int difficulty) async {
    var state = GameState.initializingGame(difficulty);
    emit(state);
    print(state.toMap());

    await Future.delayed(Duration(seconds: 3));
    startGame(difficulty);

    return state;
  }

  Future<GameState> startGame(int difficulty) async {
    var state = GameState.newGame(difficulty);
    emit(state);
    print(state.toMap());
    return state;
  }

  Future<GameState> powerOff() async {
    var state = GameState.gameOff();
    emit(state);
    print(state.toMap());
    return state;
  }
}

class GameState {
  final bool gameInitializing;
  final bool gameInProgress;
  final int difficulty;

  const GameState(
      {this.gameInitializing = false,
      this.gameInProgress = false,
      this.difficulty = 1});

  factory GameState.gameOff() => GameState(
        gameInProgress: false,
        difficulty: 1,
      );
  factory GameState.initializingGame(int difficulty) => GameState(
        gameInitializing: true,
        gameInProgress: false,
        difficulty: difficulty,
      );
  factory GameState.newGame(int difficulty) => GameState(
        gameInProgress: true,
        difficulty: difficulty,
      );

  Map<String, dynamic> toMap() {
    return {
      'initializing': gameInitializing,
      'gameInProgress': gameInProgress,
      'difficulty': difficulty,
    };
  }
}
