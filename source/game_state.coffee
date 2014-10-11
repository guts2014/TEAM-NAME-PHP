class GameState
  tick: 0

  levelWidth:  30
  levelHeight: 10

  entities: []

  money: 1000000
  reputation: 0.5

  customers: []
  custNo: 0
  requestQueues: {
    "email":   [],
    "phone":   [],
    "webchat": []
  }
  chanceOfRequest: 0.005


  calculateReputation: ->
    totalWorth = 0
    totalRep = 0
    for customer in @customers
      totalRep += customer.mood * customer.worth
      totalWorth += customer.worth
    if totalWorth != 0
      @reputation = totalRep / totalWorth

  calculateBudgetChange: ->
    #budget = 0
    #for agent in @agents
    #  budget -= agent.salary
    #for customer in @customers
    #  budget += customer.worth
    #budget
    0


  numberOfRequests: ->
    requests = 0
    for queue of @requestQueues
      requests += @requestQueues[queue].length
    requests

  toString: ->
    #"Customers: " + @customers.length +
    #"\nMoney: " + @money + " (" + @calculateBudgetChange() + ")" +
    #"\nRequest queue: " + @numberOfRequests() +
    #"\nReputation: " + (@reputation * 100) + "%" +
    #"\nAgents: " + @agents.join(", ")
    "GameState#toString()"
