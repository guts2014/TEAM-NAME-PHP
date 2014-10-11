class Request
  type: null
  time_handled: null
  time_created: null
  customer: null
  priority: null
  text: null
  elapsed: null

  constructor: (@type) ->


  resolved: ->
    @customer.increaseMood()

  tick: (state) ->
    @elasped = state.tick - @time_created
    if(@elapsed % 15 == 0)
      @customer.reduceMood()
