class Game
  constructor: (@renderer) ->
    @state = new GameState
    #@renderer.setup(@state.level.width, @state.level.height)

  doTick: ->
    @state.tick += 1
    $('.tick-count').text(@state.tick)

    for tickable in @state.tickables
      tickable.tick(@state)

    @renderer.render(@state)



  run: ->
    #@state.tickables.push(new RequestSpawner)
    #@state.request_queues = $.extend(@state.request_queues, {"email": new RequestQueue('Email Queue'), "phone": new RequestQueue('Phone Queue'), "chat": new RequestQueue('Chat Queue')})

    $.proxy(this.doTick, this)()
