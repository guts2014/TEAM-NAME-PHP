class SmallDesk extends Entity
  modelName: -> 'small_desk'

  agent: 0

  constructor: (@x, @y)->
    super(@x, @y)



  empty: () ->
    return agent == null

  assignDesk: (@agent) ->

  getAgents: () ->
    return Agent.getPotentialAgents()

  hireScreen: () ->
    ui = Game.state.ui
    agents = @getAgents()
    title = "Hire New Agent"
    hireButtons = []
    content = "Click the Button "
    me = this

    for agent in agents
      console.log(agent.name)
      name = agent.name
      email =  agent.skills.email
      phoneSkill =  agent.skills.phone
      salary =  agent.salary
      agentTx = agent.name + "\ne: " + email  + "\np: " +  phoneSkill + "\nsalary: " +  salary.toFixed(2)

      button = {text: agentTx, click: ->
                                  ui.close()
                                  me.hireAgent(agent)
                                  }
      hireButtons.push(button)


    ui.changeTitle(title)
    ui.changeContent(content)
    ui.changeButtons(hireButtons)
    ui.open()

  hireAgent: (agentD) ->
    @agent = new Agent(this.x, this.y+1, agentD)
    Agent.potentialAgents.pop(agentD)

  infoScreen: () ->
    ui = Game.state.ui

    if(!@agent)

    else
      title = @agent.name
      content = "Skills: email - " + @agent.skills.email + " | phone - " + @agent.skills.phone


      ui.changeTitle(title)
      ui.changeContent(content)
      ui.changeButtons("")
      ui.open()


  assignScreen: () ->
    console.log("assign this agent to something")
    ui = Game.state.ui
    title = "Assign to Queue"
    email_queue = Game.state.requestQueues.email
    phone_queue = Game.state.requestQueues.phone
    me = this
    buttons = [{text: "Email", click:->
                                me.agent.assign(email_queue)
                                ui.close()
                                },
              {text: "Phone", click:->
                                me.agent.assign(phone_queue)
                                ui.close()
                                }]

    ui.changeTitle(title)
    ui.changeContent("")
    ui.changeButtons(buttons)
    ui.open()

  onClick: () ->
    #show mene
    console.log('Somebody clicked me!')

    ui = Game.state.ui
    buttons = []
    me = this
    if !@agent

      title = "Empty Seat"
      content = "Nobody is sitting in this seat, hire a new employee?"
      buttons = [{text: "Hire", click: ->
                                  hire = 1

                                  ui.close()
                                  me.hireScreen()
                                  }]
    else
      title = @agent.name
      content = ""
      if(@agent.queue)
        if @agent.queue == Game.state.requestQueues.email
          content = "Assigned to email support"
        if @agent.queue == Game.state.requestQueues.phone
          content = "Assigned to phone support"

      buttons = [{text: "Info", click: ->
                                  ui.close()
                                  me.infoScreen()
                                },
                  {text: "Assign", click: ->
                                    ui.close()
                                    me.assignScreen()}]




    ui.changeTitle(title)
    ui.changeContent(content)
    ui.changeButtons(buttons)
    ui.open()

    Game.state.selectDesk = this
    Game.renderer.update(Game.state)



class LargeDesk extends SmallDesk
  modelName: -> 'large_desk'
