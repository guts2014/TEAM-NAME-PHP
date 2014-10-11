class Agent
  name: null
  queue: null             # the queue object the agent is assigned to
  salary: 0               # the salary of the agent
  request: null
  working: 0
  training: 0
  training_elapsed: 0

  constructor: ->
    @skills = {
      email: null,
      phone: null,
      webchat: null,
    }


  fromAgentData: (agent_data) ->
    @name = agent_data['name']
    @salary = agent_data['salary']
    @skills['email'] = agent_data['email']
    @skills['phone'] = agent_data['phone']
    @skills['webchat'] = agent_data['webchat']

  tick: (state) ->
    if @working > 0
      @working = @working - 1
      if @working == 0
        @request.resolved()
    else if @queue and @queue.length()
      @request = @queue.pop()


  assign: (queue) ->
    @queue = queue


  remove: ->
    @queue = null

  handleRequest: (request)->
    @request = request
    # calculate the number of ticks it will take for the agent to handle the request
    @working = (request.complexity / @skills[request.type])

  train: (skill)->
    @skills[skill] = 1
