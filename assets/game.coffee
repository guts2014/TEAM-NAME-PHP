class Game
  constructor: (@renderer) ->
    @state = new GameState
    #@renderer.setup(@state.level.width, @state.level.height)

  doTick: ->
    @state.tick += 1
    $('.tick-count').text(@state.tick)
    $('.date-display').text(new GameTime(@state.tick))
    for tickable in @state.tickables
      tickable.tick(@state)

    @renderer.render(@state)



  run: ->
    $.ajax("/assets/data/customers.json").done($.proxy((kana_customers) ->
        for kana_customer in kana_customers
          customer = new Customer
          customer.from_kana_customer kana_customer
          @state.customers.push(customer)
      , this)
    )

    @state.tickables.push(new RequestSpawner)
    @state.request_queues = $.extend(@state.request_queues, {"email": new RequestQueue('Email Queue'), "phone": new RequestQueue('Phone Queue'), "chat": new RequestQueue('Chat Queue')})

    $.proxy(this.doTick, this)
