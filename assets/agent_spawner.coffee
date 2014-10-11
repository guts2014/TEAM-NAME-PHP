class AgentSpawner
  constructor: ->
    self = this
    $.ajax("/assets/data/names.json").done( (data) ->
      console.log(data)
      self.names = data
    )

  potentialAgents: []

  getPotentialAgents: ->
    while @potentialAgents.length < 10
      @potentialAgents.push(@generateAgent())


  generateAgent: ->
    agent = new Agent
    agent.name = @randomFirstName() + " " + @randomLastName()
    salaryFactor = 0
    for key of agent.skills
      salaryFactor += agent.skills[key] = @randomSkillValue()
    agent.salary = (Math.random() * 3 + salaryFactor / 2) * 10
    agent.description = @getRandomDescription()

  randomSkillValue: ->
    Math.floor(Math.random() * 3)

  randomFirstName: ->
    name = @names[Math.floor(Math.random() * @names.length)]
    name.substr(0, 1) + name.substr(1).toLowerCase()

  randomLastName: ->
    @randomFirstName()



