class Game
  constructor: (@renderer) ->

  run: ->
    @renderer.getCell(3, 2).style.background = "green"
