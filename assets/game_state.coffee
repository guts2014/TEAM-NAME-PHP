class GameState
  customers: []
  agents: []

  requestQueues: {}

  tickables: []
  tick: 0

  money: 1000000
  reputation: 0.5
  agentSpawner: new AgentSpawner()

  addAgent: (agent) ->
    @agents.push(agent)

  fireAgent: (agent) ->
    @agents.filter((item) ->
      item != agent
    )

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
