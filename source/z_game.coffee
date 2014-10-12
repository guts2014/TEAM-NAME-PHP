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
    if Game.state.tick % 1440 == 0
      Game.state.money += Game.state.calculateBudgetChange()

    Game.state.tick += 1

    Customer.spawn()

    for entity in Game.state.entities
      entity.tick()

    Game.state.calculateReputation()
    Game.renderer.update(@state)

    $('.tick-count').text(Game.state.tick)
    $('.date-display').text(new GameTime(Game.state.tick))
    $('#customer_list').html("")
    $('#request_list')
    for customer in Game.state.customers()
      id = customer.id
      $('#customer_list').append("<li class='cust' id='cust" + id + "'>" + customer.name + "<br />Mood: "+  Math.floor(customer.mood * 100) + " Worth: " + Math.floor(customer.worth) + "</li>")


  @run: ->
    Game.renderer.setup()
    new Floor()
    new SmallDesk(2, 4)
    new SmallDesk(4, 4)
    new SmallDesk(6, 4)
    new SmallDesk(8, 4)

    Game.doTick()
    Game.renderer.render(@state)
    Game.setSimulationRate(1)

    $(".topoverlay i").click((evt) ->
      target = evt.target
      $(".topoverlay i").removeClass("selectedSpeed")
      $(target).addClass("selectedSpeed")
    )
