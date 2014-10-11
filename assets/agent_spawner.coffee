class AgentSpawner
  potential_agents: [] # Holds all potential customers from customers.json

  constructor: ->
    console.log("in AS constructor")
    $.ajax("/assets/data/agents.json").done($.proxy((data_agents) ->
        for data_agent in data_agents
          agent = new Agent
          agent.fromAgentData(data_agent)
          @potential_agents.push(agent)
      , this)
    ).error((a) ->
      console.log(a)
    )

  hireAgent: ()->
    if @potential_agents.length == 0
      return undefined
    $.extend({}, @potential_agents[Math.floor(Math.random() * @potential_agents.length)])
