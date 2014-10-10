import 'dart:html';

class Game {
  GameRenderer renderer;
  
  Game(this.renderer);
  
  
  void run() {
    renderer.getCell(1, 3).style.background = "green";
  }
}



class GameRenderer {
  Element getGameTable() {
    return querySelector('#game');
  }
  Element getCell(num x, num y) {
    var table = getGameTable();
    return table.querySelectorAll('tr')[y].querySelectorAll('td')[x];
  }
}



void main() {
  GameRenderer renderer = new GameRenderer();
  Game game = new Game(renderer);
  
  game.run();
}