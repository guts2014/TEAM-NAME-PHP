class Request
  type: null
  time_created: null
  customer: null
  priority: null
  text: null
  elapsed: null

<<<<<<< HEAD
  constructor: () ->
=======
  constructor: (state, @type, @customer) ->
    @time_created = state.tick

>>>>>>> FETCH_HEAD

  resolved: ->
    @customer.increaseMood(5)

  create: (@type, @time_created, @customer, @priority, @complexity, @text) ->

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
