import 'dart:html';

class Game {
  
  
}


Element getGameTable() {
  return querySelector('#game');
}
Element getCell(x, y) {
  var table = getGameTable();
  return table.querySelectorAll('tr')[y].querySelectorAll('td')[x];
}


void main() {
  getCell(2,3).style.background = "green";
}