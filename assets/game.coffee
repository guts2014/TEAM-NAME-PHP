class Game
  width:  10
  height: 3
  level:  []

  constructor: (@renderer) ->
    for i in [0..@width]
      @level[i] = new Array(@height)
    console.log(@level)

    @renderer.setup(@width, @height)





  run: ->
    @renderer.getCell(3, 2).style.background = "green"
