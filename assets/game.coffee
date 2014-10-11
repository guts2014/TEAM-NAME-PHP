class Game
  constructor: (@renderer) ->
    @state = new GameState

    for i in [0..@state.width]
      @state.level[i] = new Array(@state.height)
    @renderer.setup(@state.width, @state.height)

  doTick: ->
    @state.tick += 1

    for tickable in @state.tickables
      tickable.tick(@state)

    @renderer.update(@state)

  run: ->
    @renderer.getCell(3, 2).style.background = "green"


    @state.request_queues = $.extend(@state.request_queues, {"email": new RequestQueue('Email Queue'), "phone": new RequestQueue('Phone Queue'), "chat": new RequestQueue('Chat Queue')})

    setTimeout $.proxy(this.doTick, this), 100
