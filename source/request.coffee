class RequestLoader
  constructor: (state) ->
    $.ajax("assets/data/requests.json").done(state.requestQueues)

class Request
  type: null
  customer: null
  priority: null
  text: null
  handled: null
  elapsed: null

  constructor: (@type, @customer) ->
    @time_created = Game.state.tick

  resolved: ->
    @customer.increaseMood(5)
    @customer.removeRequest()

  create: (@type, @time_created, @customer, @priority, @complexity, @text) ->

  createFromRequestData: (request_data,  tick, customer) ->
    @create(request_data['type'],
            tick,
            customer,
            request_data['priority'],
            request_data['complexity'],
            request_data['text'])

  tick: ->
    elapsed = Game.state.tick - @time_created
    if(elapsed % 2 == 0)
      @customer.reduceMood()
