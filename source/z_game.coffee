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
    $('#email_queue').html("")
    $('#phone_queue').html("")
    for email in Game.state.requestQueues.email
      if !email.handled
        id = 1 #email.id
        age = 0 #(Game.state.tick - email.time_created)
        $("#email_queue").append("<li class='req' id='req_id'>" + email.text + "<br /></li>")

    for phone in Game.state.requestQueues.phone
      if !phone.handled
        id = 1 #phone.id
        #age = (Game.state.tick - phone.time_created)
        age= 0
        $("#phone_queue").append("<li class='req' id='req" + id + "'>" + phone.text + "<br /></li>")

    for customer in Game.state.customers()
      id = customer.id
      $('#customer_list').append("<li class='cust' id='cust" + id + "'>" + customer.name + "<br />Mood: "+  Math.floor(customer.mood * 100) + " Worth: " + Math.floor(customer.worth) + "</li>")


  @run: (mode) ->
    Game.renderer.setup()
    new Floor()
    Game.state.mode = mode
    Request.loadRequests()
    Game.doTick()
    Game.renderer.render(@state)
    Game.setSimulationRate(1)

    $(".topoverlay i").click((evt) ->
      target = evt.target
      $(".topoverlay i").removeClass("selectedSpeed")
      $(target).addClass("selectedSpeed")
    )
