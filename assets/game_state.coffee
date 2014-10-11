class GameState
  customers: []
  agents: []

  requestQueues: {}
  chanceOfRequest: 0.005

  tickables: []
  tick: 0

  money: 1000000
  reputation: 0.5
  agentSpawner: new AgentSpawner()

  addAgent: (agent) ->
    @agents.push(agent)
    @tickables.push(agent)

  fireAgent: (agent) ->
    @agents.filter((item) ->
      item != agent
    )

  removeCustomer: (customer) ->
    @customers.filter((item) ->
      item != customer
    )

  calculateReputation: ->
    totalWorth = 0
    totalRep = 0
    for customer in @customers
      totalRep += customer.mood * customer.worth
      totalWorth += customer.worth
    if totalWorth != 0
      @reputation = totalRep / totalWorth

  calculateBudgetChange: ->
    budget = 0
    for agent in @agents
      budget -= agent.salary
    for customer in @customers
      budget += customer.worth
    budget

  constructor: ->
    @level = new Level

  numberOfRequests: ->
    requests = 0
    for queue of @requestQueues
      requests += @requestQueues[queue].length()
    requests

  toString: ->
    "Customers: " + @customers.length +
    "\nMoney: " + @money + " (" + @calculateBudgetChange() + ")" +
    "\nRequest queue: " + @numberOfRequests() +
    "\nReputation: " + (@reputation * 100) + "%" +
    "\nAgents: " + @agents.join(", ")
