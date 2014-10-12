class SmallDesk extends Entity
  modelName: -> 'small_desk'

  agent: null

  constructor: (@x, @y)->
    super(@x, @y)


  empty: () ->
    return agent == null

  assignDesk: (@agent) ->


  onClick: () ->
    #show menu
    console.log('Somebody clicked me!')
    Game.state.selectedDesk = this
    Game.renderer.update(Game.state)


class LargeDesk extends SmallDesk
  modelName: -> 'large_desk'
