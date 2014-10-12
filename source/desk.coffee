class SmallDesk extends Entity
  modelName: -> 'small_desk'

  agent: 0

  constructor: (@x, @y)->
    super(@x, @y)



  empty: () ->
    return agent == null

  assignDesk: (@agent) ->


  onClick: () ->
    #show mene
    #console.log('Somebody clicked me!')
    $( "#dialog" ).dialog "option", "buttons", [
      text: "Ok"
      click: ->
        $(this).dialog "close"
        return
      ]

    $( "#dialog" ).dialog( "open" );
    if Game.state.selectedDesk == this
      # this desk is already selected

    else

      if !@agent
        potAgents = Agent.getPotentialAgents()
        for agnt in potAgents
          console.log(agnt.name)
      else
      Game.renderer.update(Game.state)



class LargeDesk extends SmallDesk
  modelName: -> 'large_desk'
