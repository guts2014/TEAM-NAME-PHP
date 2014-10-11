class Game
  @simulating: false
  @state:      new GameState()
  @renderer:   new GameRenderer()

  @setSimulationRate: (rate) ->
    if @interval
      clearInterval(@interval)
    if rate > 0
      @interval = setInterval $.proxy(this.doTick, this), (500 / rate)

  @doTick: ->
    Game.state.tick += 1

    Customer.spawn()

    for entity in Game.state.entities
      entity.tick()

    Game.state.calculateReputation()
    Game.renderer.update(@state)

    $('.tick-count').text(Game.state.tick)
    $('.date-display').text(new GameTime(Game.state.tick))
    $('#gamestate').html(Game.state.toString().replace(/\n/g, "<br />"))
    $('#customer_list').html("")
    for customer in Game.state.customers()
      id = customer.id
      $('#customer_list').append("<li class='cust' id='cust" + id + "'>" + customer.name + "<br />Mood: "+  Math.floor(customer.mood) + "</li>")


  @run: ->
    new SmallDesk(3,2)
    new LargeDesk(8,5)

    Game.renderer.setup()
    Game.doTick()
    Game.renderer.render(@state)
