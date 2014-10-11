class Game
  constructor: (@renderer) ->
    @state = new GameState

    for i in [0..@state.width]
      @state.level[i] = new Array(@state.height)
    @renderer.setup(@state.level.width, @state.level.height)

  doTick: ->
    @state.tick += 1
    $('.tick-count').text(@state.tick)

    for tickable in @state.tickables
      tickable.tick(@state)

    @renderer.update(@state)



  run: ->
    @state.tickables.push(new RequestSpawner)
    @state.request_queues = $.extend(@state.request_queues, {"email": new RequestQueue('Email Queue'), "phone": new RequestQueue('Phone Queue'), "chat": new RequestQueue('Chat Queue')})

    $.proxy(this.doTick, this)
