class RequestQueue
  type: ''

  push: (request) ->
    @requests.push(request)

  pop: ->
    return @requests[0]

  constructor: (@name) ->
    @requests = []

  length: ->
    @requests.length
