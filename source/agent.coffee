class Agent extends Entity
  modelName: -> 'agent'

  name: null
  queue: null             # the queue object the agent is assigned to
  salary: 0               # the salary of the agent
  request: null
  working: 0
  training: 0
  training_elapsed: 0
  completed: 0


  constructor: (x, y)->
    super(x, y)
    @skills = {
      email: null,
      phone: null,
      webchat: null,
    }

    #@name = @randomName() + " " + @randomName()
    @name = "bob."
    salaryFactor = 0
    for key of @skills
      salaryFactor += @skills[key] = Math.floor(Math.random() * 3)
    @salary = (Math.random() * 3 + salaryFactor / 2) * 10
    @description = ""

  @fromAgentData: (agent_data) ->
    agent = new Agent
    agent.name              = agent_data['name']
    agent.salary            = agent_data['salary']
    agent.skills['email']   = agent_data['email']
    agent.skills['phone']   = agent_data['phone']
    agent.skills['webchat'] = agent_data['webchat']

  tick: (state) ->
    console.log("Working " + @working + ", request: " + @request)
    if @working > 0
      @working -= 1
      if @working == 0
        @completed++
        @request.resolved()
        @request = null
    else if @training > 0
      @training -= 1
      if @training == 0
        @skills[@trainingSkill] += 1
        @trainingSkill = null
    else if @queue and @queue.length
       @handleRequest(@queue.pop())


  assign: (queue) ->
    @queue = queue

  remove: ->
    @queue = null

  handleRequest: (request)->
    @request = request
    # calculate the number of ticks it will take for the agent to handle the request
    @working = Math.floor(request.complexity / @skills[request.type])

  train: (skill)->
    @trainingSkill = skill
    @training = 30

  toString: ->
    "Name: " + @name + ", request: " + @request + ", completed: " + @completed + ", training: " + @trainingSkill
