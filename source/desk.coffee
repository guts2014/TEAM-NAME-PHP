class SmallDesk extends Entity
  modelName: -> 'small_desk'

  agent: 0

  constructor: (@x, @y)->
    super(@x, @y)



  empty: () ->
    @agent = null

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

      buttonClick = (agent_) ->
        ui.close()
        me.hireAgent(agent_)
      button = {text: agentTx, click: $.proxy(buttonClick, this, agent)}
      hireButtons.push(button)

    ui.changeTitle(title)
    ui.changeContent(content)
    ui.changeButtons(hireButtons)
    ui.open()

  hireAgent: (agentD) ->
    @agent = new Agent(this.x, this.y+1, agentD)
    Agent.potentialAgents = Agent.potentialAgents.filter((agent) ->
      agent != agentD
    )

  infoScreen: () ->
    ui = Game.state.ui
    if @agent
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
    buttonEmailClick = ->
      me.agent.assign(email_queue)
      ui.close()
    buttonPhoneClick = ->
      me.agent.assign(phone_queue)
      ui.close()
    buttons = [{text: "Email", click: buttonEmailClick},
              {text: "Phone", click: buttonPhoneClick}]

    ui.changeTitle(title)
    ui.changeContent("")
    ui.changeButtons(buttons)
    ui.open()

  fireScreen: () ->
    ui = Game.state.ui
    me = @
    agent = @agent
    title = "Fire Agent"
    content = "Do you really wish to fire " + @agent.name
    buttonClick = ->
      me.empty()
      agent.remove()
      ui.close()
    buttons = [{text: "Yes", click: $.proxy(buttonClick, this)}]

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
      buttonClick = ->
        hire = 1
        ui.close()
        me.hireScreen()
      buttons = [{text: "Hire", click: buttonClick}]
    else
      title = @agent.name
      content = ""
      if(@agent.queue)
        if @agent.queue == Game.state.requestQueues.email
          content = "Assigned to email support"
        if @agent.queue == Game.state.requestQueues.phone
          content = "Assigned to phone support"
        if @agent.request
          content = content + "\n" + "Working on " + @agent.request.text + " time left : " + @agent.working

      buttonInfoClick = ->
        ui.close()
        me.infoScreen()
      buttonAssignClick = ->
        ui.close()
        me.assignScreen()
      buttonFireClick = ->
        ui.close()
        me.fireScreen()
      buttons = [{text: "Info", click: buttonInfoClick},
              {text: "Assign", click: buttonAssignClick},
              {text: "Fire", click: buttonFireClick}]




    ui.changeTitle(title)
    ui.changeContent(content)
    ui.changeButtons(buttons)
    ui.open()

    Game.state.selectDesk = this
    Game.renderer.update(Game.state)



class LargeDesk extends SmallDesk
  modelName: -> 'large_desk'
