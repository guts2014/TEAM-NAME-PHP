class Customer
  name: ''
  worth: 100
  volatility: 50
  mood: 100

  tick: (state) ->
    if Math.random() < 0.02 # Per customer, 2% chance of spawning a support request per tick
      switch Math.floor(Math.random() * 2)
        when 0
          requestType = "email"
        when 1
          requestType = "phone"
      requestQueue = state.requestQueues[requestType]
      requestQueue.push(new Request(requestType))


  lower_mood: ->
    @mood -= 5

  increase_mood: ->
    if(@mood <= 100)
      @mood += 5
      if(@mood > 100)
        mood = 100


  remove: ->

  create_request: ->

  from_kana_customer: (kana) ->
    @name = kana['firstName'] + " " + kana['surname']
    @volatility = +kana['customerVolatilityScore']
    @worth = +kana['netPromoterScore']
