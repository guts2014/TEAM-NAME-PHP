class Game
  constructor: (@renderer) ->
    @state = new GameState

    for i in [0..@state.width]
      @state.level[i] = new Array(@state.height)
    @renderer.setup(@state.width, @state.height)

  doTick: ->
    @state.tick += 1
    $('.tick-count').text(@state.tick)

    for tickable in @state.tickables
      tickable.tick(@state)

    @renderer.update(@state)

  run: ->
    @state.tickables.push(new RequestSpawner)


    @renderer.getCell(3, 2).style.background = "green"


    q = new RequestQueue('Test Queue')
    @state.request_queues.push q

    setTimeout $.proxy(this.doTick, this), 100
