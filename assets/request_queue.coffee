class RequestQueue
  requests: []
  type: ''

  top_of_queue: ->
    return @requests[0]

  constructor: (@name) ->

  length: ->
    @requests.length
