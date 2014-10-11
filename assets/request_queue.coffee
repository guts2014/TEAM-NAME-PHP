class RequestQueue
  type: ''

  push: (request) ->
    @requests.push(request)

  pop: ->
    @requests.pop()

  constructor: (@name) ->
    @requests = []

  length: ->
    @requests.length
