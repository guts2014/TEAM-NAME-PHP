class Customer
  name: ''
  worth: 100
  volatility: 1
  mood: 1
  request: null

  constructor: ->

  tick: (state) ->
    if @request
      @request.tick(state)
    else if Math.random() < 0.02 # Per customer, 2% chance of spawning a support request per tick
      this.createRequest(state)

  reduceMood: (multiplier = 1) ->
    @mood -= (0.05 * multiplier * @volatility)

  increaseMood: (multiplier = 1) ->
    if(@mood < 1)
      @mood += (0.05 * multiplier)
      if(@mood > 1)
        @mood = 1

  removeRequest: ->
    @request = null

  createRequest: (state) ->
    switch Math.floor(Math.random() * 2)
      when 0
        requestType = "email"
      when 1
        requestType = "phone"
    requestQueue = state.requestQueues[requestType]
    requestQueue.push(@request = new Request(state,requestType, this))


  fromKanaCustomer: (kana) ->
    @name = kana['firstName'] + " " + kana['surname']
    @volatility = +kana['customerVolatilityScore']
    @worth = +kana['netPromoterScore']
