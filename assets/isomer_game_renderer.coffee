class IsomerGameRenderer
  constructor: ->
    @iso = new Isomer(document.getElementById('game'))


  render: (state) ->
    #console.log('Rendering ... ', state)

    # First draw the floor
    @iso.add(Isomer.Shape.Prism(Isomer.Point.ORIGIN, state.level.width, state.level.height, 1))


    window.requestAnimationFrame($.proxy(this.render, this, state))
