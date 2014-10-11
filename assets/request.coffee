class Request
  type: null
  time_created: null
  customer: null
  priority: null
  text: null
  elapsed: null

  constructor: (state, @type, @customer) ->
    @time_created = state.tick


  resolved: ->
    @customer.increaseMood()

  tick: (state) ->
    elapsed = state.tick - @time_created
    if(elapsed % 15 == 0)
      @customer.reduceMood()
