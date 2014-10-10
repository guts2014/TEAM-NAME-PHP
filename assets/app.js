"use strict";

var gamestate = {


}



function getGameTable() {
  return document.querySelector('#game');
}
function getCell(x, y) {
  var table = getGameTable();
  return table.getElementsByTagName('tr')[y].getElementsByTagName('td')[x];
}
