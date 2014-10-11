class Request
  type: null
  time_handled: null
  time_created: null
  customer: null
  priority: null
  text: null
  resolved: 0
  elapsed: null

  constructor: (@type) ->


  resolved: ->
    @resolved = 1
    @request = null

  tick: (state) ->
    @elasped = state.tick - @time_created
    if(@elapsed % 15 == 0)
      @customer.reduceMood()
