class Request
  @potential_requests: []

  type: null
  customer: null
  priority: null
  text: null
  handled: null
  elapsed: null
  alive: null

  $.ajax("assets/data/requests.json").done($.proxy((data_requests) ->
    @potential_requests = data_requests[Game.state.mode]
  , this)
  )

  constructor: (@type, @customer) ->
    @alive = 1
    @time_created = Game.state.tick
    reqType = @type
    requests = Request.potential_requests
    randomRequest = Math.floor(Math.random() * requests[type].length)

    @createFromRequestData(requests[reqType][randomRequest])



  resolved: ->
    @customer.increaseMood(5)
    @handled = 1
    @alive = 0
    @customer.removeRequest()

  createFromRequestData: (request_data) ->
    #@priority   = request_data['priority']
    @complexity = request_data['complexity']
    @text       = request_data['text']

  tick: ->
    elapsed = Game.state.tick - @time_created
    if(elapsed % 5 == 0)
      @customer.reduceMood()
