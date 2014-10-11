class Customer
  name: ''
  worth: 100
  volatility: 50
  mood: 100

  update: ->

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
    console.log(kana)
    @name = kana['firstName'] + " " + kana['surname']
    @volatility = +kana['customerVolatilityScore']
    @worth = +kana['netPromoterScore']
