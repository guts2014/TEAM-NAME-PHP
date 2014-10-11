class Agent
  name= null

  skills =
  email: null
  phone: null
  webchat: null

  queue: null             # the queue object the agent is assigned to
  salary: 0               # the salary of the agent
  current_request: null
  working: 0
  training: 0
  training_elapsed: 0



  tick: (state) ->

  assign: (queue) ->
    @queue = queue
  remove: ->
    @queue = null

  handleRequest: (request)->
    @current_request = request

  train: (skill)->
    @skills.skill += 1

  fromAgentData: (agent_data) ->
    @name = agent_data['name']
    @salary = agent_data['salary']
    @skills.email = agent_data['email']
    @skills.phone = agent_data['phone']
    @skills.webchat = agent_data['webchat']
