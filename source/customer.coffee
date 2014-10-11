class CustomerSpawner
  potential_customers: [] # Holds all potential customers from customers.json

  constructor: ->
    $.ajax("assets/data/customers.json").done($.proxy((kana_customers) ->
        for kana_customer in kana_customers
          customer = new Customer
          customer.fromKanaCustomer kana_customer
          @potential_customers.push(customer)
      , this)
    )

  calculateMaximumCustomers: (reputation) ->
    200 * Math.pow(reputation, 1.5)

  tick: (state) ->
    reputation = state.reputation
    if @potential_customers.length > 0 and Math.random() < reputation and this.calculateMaximumCustomers(reputation) > state.customers.length
      customer = @potential_customers.pop()
      customer.id = state.custNo
      state.customers.push(customer)
      state.tickables.push(customer)
      state.custNo++
      if @potential_customers.length == 0
        this.constructor()


class Customer extends Entity
  name: ''
  worth: 100
  volatility: 0.25
  mood: 1
  request: null

  constructor: ->

  tick: ->
    if @request
      @request.tick()
    else if Math.random() < state.chanceOfRequest # Per customer, 2% chance of spawning a support request per tick
      this.createRequest()


  reduceMood: (multiplier = 1) ->
    @mood -= (0.05 * multiplier * @volatility)
    if @mood < 0
      @mood = 0 # TODO - remove customer?

  increaseMood: (multiplier = 1) ->
    if(@mood < 1)
      @mood += (0.05 * multiplier * @volatility)
      if(@mood > 1)
        @mood = 1

  removeRequest: ->
    @request = null

  createRequest: ->
    switch Math.floor(Math.random() * 3)
      when 0
        requestType = "email"
      when 1
        requestType = "phone"
      when 2
        requestType = "webchat"
    requestQueue = state.requestQueues[requestType]
    requestQueue.push(@request = new Request(state, requestType, this, 5))

  fromKanaCustomer: (kana) ->
    @name = kana['firstName'] + " " + kana['surname']
    @volatility = +kana['customerVolatilityScore'] / 100
    @worth = +kana['netPromoterScore']

  cleanup: ->
    $('#cust' + id).remove()
