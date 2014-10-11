class Customer
  name: ''
  worth: 100
  volatility: 0.25
  mood: 1
  request: null

  constructor: ->

  tick: (state) ->
    if @request
      @request.tick(state)
    else if Math.random() < state.chanceOfRequest # Per customer, 2% chance of spawning a support request per tick
      this.createRequest(state)


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

  createRequest: (state) ->
    switch Math.floor(Math.random() * 3)
      when 0
        requestType = "email"
      when 1
        requestType = "phone"
      when 2
        requestType = "webchat"
    requestQueue = state.requestQueues[requestType]
    requestQueue.push(@request = new Request(state,requestType, this, 5))

  fromKanaCustomer: (kana) ->
    @name = kana['firstName'] + " " + kana['surname']
    @volatility = +kana['customerVolatilityScore'] / 100
    @worth = +kana['netPromoterScore']
