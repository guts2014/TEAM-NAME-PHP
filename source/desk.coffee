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
    @agent = new Agent(this.x, this.y, agentD)

  onClick: () ->
    #show mene
    console.log('Somebody clicked me!')

    ui = Game.state.ui
    buttons = ""
    if !@agent
      me = this
      title = "Empty Seat"
      content = "Nobody is sitting in this seat, hire a new employee?"
      buttons = [{text: "Hire", click: ->
                                  hire = 1

                                  ui.close()
                                  me.hireScreen()
                                  }]
    else
      title = @agent.name
      content = "Buttons"




    ui.changeTitle(title)
    ui.changeContent(content)
    ui.changeButtons(buttons)
    ui.open()

    Game.state.selectDesk = this
    Game.renderer.update(Game.state)



class LargeDesk extends SmallDesk
  modelName: -> 'large_desk'
