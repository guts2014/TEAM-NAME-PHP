class Customer
  name: ''
  worth: 100
  volatility: 50

  update: ->

  remove: ->

  create_request: ->

  from_kana_customer: (kana) ->
    console.log(kana)
    @name = kana['firstName'] + " " + kana['surname']
    @volatility = +kana['customerVolatilityScore']
    @worth = +kana['netPromoterScore']
