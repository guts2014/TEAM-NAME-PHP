class Request
  type: null
  time_handled: null
  time_created: null
  customer: null
  priority: null
  text: null
  elapsed: null

  constructor: () ->

  resolved: ->
    @customer.increaseMood()

  create: (@type, @time_created, @customer, @priority, @complexity, @text) ->

  createFromRequestData: (request_data,  tick, customer) ->
    @create(request_data['type'],
            tick,
            customer,
            request_data['priority'],
            request_data['complexity'],
            request_data['text'])

  tick: (state) ->
    @elasped = state.tick - @time_created
    if(@elapsed % 15 == 0)
      @customer.reduceMood()
