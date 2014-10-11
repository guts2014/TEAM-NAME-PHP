class RequestQueue
  requests: []
  type: ''

  push: (request) ->
    @requests.push(request)

  pop: ->
    return @requests[0]

  constructor: (@name) ->

  length: ->
    @requests.length
