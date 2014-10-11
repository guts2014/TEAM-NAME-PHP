class Game
  constructor: (@renderer) ->
    @simulating = false
    @state = new GameState
    @renderer.setup(@state)

  doTick: ->
    @state.tick += 1
    $('.tick-count').text(@state.tick)
    $('.date-display').text(new GameTime(@state.tick))
    for tickable in @state.tickables
      tickable.tick(@state)

    @renderer.render(@state)

  toggleSimulating: ->
    if @simulating
      clearInterval @interval
    else
      @interval = setInterval $.proxy(this.doTick, this), 1000
    @simulating = !@simulating
    $("#playText").text(@simulating ? "Pause" : "Unpause")

  run: ->
    @state.customer_spawner = new CustomerSpawner

    @state.tickables.push(new RequestSpawner)
    @state.request_queues = $.extend(@state.request_queues, {"email": new RequestQueue('Email Queue'), "phone": new RequestQueue('Phone Queue'), "chat": new RequestQueue('Chat Queue')})

    $.proxy(this.doTick, this)()
