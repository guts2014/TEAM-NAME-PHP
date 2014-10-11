class RequestQueue
  requests: []
  name: ''

  constructor: (@name) ->

  length: ->
    @requests.length
