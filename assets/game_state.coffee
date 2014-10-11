class GameState
  customers: []
  agents: []

  requestQueues: {}

  tickables: []
  tick: 0

  money: 1000000
  reputation: 0.5
  agent_spawner = AgentSpawner()

  addAgent: (agent) ->
    @agents.append(agent)

  fireAgent: (agent) ->
    @agents.pop(agent)

  calculateReputation: ->
    totalWorth = 0
    totalRep = 0
    for customer in @customers
      totalRep += customer.mood * customer.worth
      totalWorth += customer.worth
    if totalWorth != 0
      @reputation = totalRep / totalWorth

  constructor: ->
    @level = new Level

  numberOfRequests: ->
    requests = 0
    for queue of @requestQueues
      requests += @requestQueues[queue].length()
    requests

  toString: ->
    "Customers: " + @customers.length +
    "\nRequests: " + @numberOfRequests() +
    "\nReputation: " + (@reputation * 100) + "%"
