class AgentSpawner
  potential_agents: [] # Holds all potential customers from customers.json


constructor: ->
  $.ajax("/assets/data/agents.json").done($.proxy((data_agents) ->
      for data_agent in data_agents
        agent = new Agent
        agent.fromAgentData(data_agent)
        @potential_agents.push(agent)
    , this)
  )
  hireAgent: ()->
    agent = potential_agents[Math.floor(Math.random() * potential_agents.length())]
    potential_agents.pop(agent)
    return agent
