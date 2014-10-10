class Game
  constructor: (@renderer) ->

  run: ->
    @renderer.getCell(3, 2).style.background = "green"

class GameRenderer
  getTable: ->
    document.querySelector "#game"
  getCell: (x, y) ->
    table = this.getTable()
    table.getElementsByTagName("tr")[y].getElementsByTagName("td")[x]


renderer = new GameRenderer
game     = new Game renderer
game.run()
