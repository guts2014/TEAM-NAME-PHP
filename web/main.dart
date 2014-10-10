import 'package:simulationthingy/simulationthingy.dart';

void main() {
  GameRenderer renderer = new GameRenderer();
  Game game = new Game(renderer);
  game.run();
}