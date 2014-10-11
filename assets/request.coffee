class Request
  type: null
  customer: null
  text: null
  handled: null
  elapsed: null

  constructor: (state, @type, @customer, @complexity) ->
    @time_created = state.tick

  resolved: ->
    @customer.increaseMood(5)
    @customer.request = null

  createFromRequestData: (request_data,  tick, customer) ->
    @create(request_data['type'],
            tick,
            customer,
            request_data['priority'],
            request_data['complexity'],
            request_data['text'])

  tick: (state) ->
    elapsed = state.tick - @time_created
    if(elapsed % 2 == 0)
      @customer.reduceMood()
