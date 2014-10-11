class GameState
  tick: 0

  levelWidth:  30
  levelHeight: 10

  entities: []

  money: 1000000
  reputation: 0.5

  custNo: 0
  requestQueues: {
    "email":   [],
    "phone":   [],
    "webchat": []
  }
  chanceOfRequest: 0.005


  customers: ->
    @entities.filter((entity) ->
      entity instanceof Customer
    )
  agents: ->
    @entities.filter((entity) ->
      entity instanceof Agent
    )

  calculateReputation: ->
    totalWorth = 0
    totalRep = 0
    for customer in this.customers()
      totalRep += customer.mood * customer.worth
      totalWorth += customer.worth
    if totalWorth != 0
      @reputation = totalRep / totalWorth

  calculateBudgetChange: ->
    budget = 0
    for agent in this.agents()
      budget -= agent.salary
    for customer in this.customers()
      budget += customer.worth
    budget

  numberOfRequests: ->
    requests = 0
    for queue of @requestQueues
      requests += @requestQueues[queue].length
    requests

  toString: ->
    "Customers: " + this.customers().length +
    "\nMoney: " + @money + " (" + @calculateBudgetChange() + ")" +
    "\nRequest queue: " + @numberOfRequests() +
    "\nReputation: " + (@reputation * 100) + "%" +
    "\nAgents: " + this.agents().join(", ")
