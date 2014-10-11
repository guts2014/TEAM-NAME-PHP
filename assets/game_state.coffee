class GameState
  customers: []
  agents: []

  requestQueues: {}

  tickables: []
  tick: 0

  money: 1000000
  reputation: 0.5

  constructor: ->
    @level = new Level

  numberOfRequests: ->
    requests = 0
    for queue of @requestQueues
      requests += @requestQueues[queue].length()
    requests
