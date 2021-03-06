class Customer extends Entity
  @potential_customers: []
  @calculateMaximumCustomers: ->
    20 * Math.pow(Game.state.reputation + 1, 1.5)

  @spawn: ->
    if Customer.potential_customers.length == 0
      $.ajax("assets/data/customers.json").done($.proxy((kana_customers) ->
          @potential_customers = kana_customers
        , this)
      )

    if @potential_customers.length > 0 and Game.state.reputation > 0 and Math.random() < Game.state.reputation and Customer.calculateMaximumCustomers() > Game.state.customers().length
      customer = new Customer
      customer.fromKanaCustomer(@potential_customers.pop())
      customer.id = Game.state.custNo
      Game.state.custNo++

  name: ''
  worth: 100
  volatility: 0.25
  mood: 0.7
  request: null

  fromKanaCustomer: (kana) ->
    @name = kana['firstName'] + " " + kana['surname']
    @volatility = +kana['customerVolatilityScore'] / 100
    @worth = +kana['netPromoterScore'] * 1.5

  tick: ->
    if @request
      @request.tick()
    else if Math.random() < Game.state.chanceOfRequest # Per customer, 2% chance of spawning a support request per tick
      this.createRequest()
    if @mood <= 0
      this.remove()


  reduceMood: (multiplier = 1) ->
    @mood -= (0.05 * multiplier * Math.pow(@volatility, 1.2))
    if @mood < 0
      @mood = 0 # TODO - remove customer?

  increaseMood: (multiplier = 1) ->
    if(@mood < 1)
      @mood += (0.05 * multiplier * @volatility)
      if(@mood > 1)
        @mood = 1

  removeRequest: ->
    Game.state.requestQueues[@requestType] = Game.state.requestQueues[@requestType].filter((item) ->
      item != @request
    )
    @request = null

  createRequest: ->

    switch Math.floor(Math.random() * 2)
      when 0
        @requestType = "email"
      when 1
        @requestType = "phone"

    requestQueue = Game.state.requestQueues[@requestType]
    requestQueue.push(@request = new Request(@requestType, this))

  cleanup: ->
    $('#cust' + @id).remove()
    @removeRequest()
