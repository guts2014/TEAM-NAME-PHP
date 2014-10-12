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
      agentTx = agent.name + "\ne:" + email  + "\np:" +  phoneSkill + "\nsalary:" +  salary

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
    console.log('agent added')
    @agent = new Agent(this.x, this.y-1, agentD)

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
    ui = Game.state.ui
    title = "Assign to Queue"
    email_queue = Game.state.requestQueues.email
    phone_queue = Game.state.requestQueues.phone

    buttons = [{text: "Email", click:->
                                ui.close()
                                @agent.assign(email_queue)},
              {text: "Phone", click:->
                                ui.close()
                                @agent.assign(phone_queue)}]
    ui.changeTitle(title)
    ui.changeContent(content)
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
      buttons = [{text: "Info", click: ->
                                  ui.close()
                                  me.infoScreen()
        }]




    ui.changeTitle(title)
    ui.changeContent(content)
    ui.changeButtons(buttons)
    ui.open()

    Game.state.selectDesk = this
    Game.renderer.update(Game.state)



class LargeDesk extends SmallDesk
  modelName: -> 'large_desk'
