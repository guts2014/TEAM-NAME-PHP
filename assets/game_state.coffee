class GameState
  customers: []
  agents: []

  requestQueues: {}

  tickables: []
  tick: 0

  money: 1000000

  constructor: ->
    @level = new Level
