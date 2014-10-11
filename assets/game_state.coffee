class GameState
  customers: []
  agents: []

  request_queues: {}

  tickables: []
  tick: 0

  money: 1000000

  constructor: ->
    @level = new Level
