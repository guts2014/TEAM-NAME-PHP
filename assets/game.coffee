class Game
  constructor: (@renderer) ->
    @simulating = false
    @state = new GameState
    @renderer.setup(@state)

  doTick: ->
    @state.tick += 1
    $('.tick-count').text(@state.tick)
    $('.date-display').text(new GameTime(@state.tick))
    $('#gamestate').text(@state)
    for tickable in @state.tickables
      try
        tickable.tick(@state)
      catch error
        console.log("error %o ticking %o", error, tickable)
    @state.calculateReputation()

    @renderer.render(@state)

  toggleSimulating: ->
    if @simulating
      clearInterval @interval
    else
      @interval = setInterval $.proxy(this.doTick, this), 1000
    @simulating = !@simulating
    $("#playText").text(if @simulating then "Pause" else "Unpause")

  run: ->
    @state.tickables.push(new CustomerSpawner)
    @state.requestQueues = $.extend(@state.requestQueues, {"email": new RequestQueue('Email Queue'), "phone": new RequestQueue('Phone Queue'), "webchat": new RequestQueue('Chat Queue')})

    $.proxy(this.doTick, this)()
