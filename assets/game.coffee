class Game
  width:  10
  height: 10
  level:  []

  constructor: (@renderer) ->
    for i in [0..@width]
      @level[i] = new Array(@height)
    @renderer.setup(@width, @height)

  doTick: ->
    @renderer.update()

  run: ->
    @renderer.getCell(3, 2).style.background = "green"

    setTimeout $.proxy(this.doTick, this), 100
