class Game
  constructor: (@renderer) ->
    @simulating = false
    @state = new GameState
    @renderer.setup(@state)


  doTick: ->
    @state.tick += 1
    $('.tick-count').text(@state.tick)
    $('.date-display').text(new GameTime(@state.tick))
    $('#gamestate').html(@state.toString().replace(/\n/g, "<br />"))
    $('#customer_list').html("")
    for customer in @state.customers
      $('#customer_list').append("<li class='cust'>" + customer.name + "</li>")

    for tickable in @state.tickables
      tickable.tick(@state)
    @state.calculateReputation()

    @renderer.update(@state)

  toggleSimulating: ->
    if @simulating
      clearInterval @interval
    else
      @interval = setInterval $.proxy(this.doTick, this), 1000
    @simulating = !@simulating
    $("#playText").text(if @simulating then "Pause" else "Unpause")

  run: ->
    for y in [2, 4, 6, 8]
      for x in [2, 4, 6, 8, 10]
        @state.level.desks.push(new Desk(x,y))
        @state.level.people.push(new Person(x,y))



    @state.tickables.push(new CustomerSpawner)
    @state.requestQueues = $.extend(@state.requestQueues, {"email": new RequestQueue('Email Queue'), "phone": new RequestQueue('Phone Queue'), "webchat": new RequestQueue('Chat Queue')})

    $.proxy(this.doTick, this)()

    @renderer.render(@state)
