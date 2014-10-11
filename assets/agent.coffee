class Agent
  skills: []
  queue: null

  assign: (queue) ->
    @queue = queue
  remove: ->
    @queue = null

  handle_request: ->
