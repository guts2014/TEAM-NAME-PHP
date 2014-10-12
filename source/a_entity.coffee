class Entity
  x: 0
  y: 0


  @model: null
  threeObject: null
  modelName: -> null

  constructor: (@x, @y) ->
    if !@model and this.modelName()
      @model = GameRenderer.getModel(this.modelName())
    Game.state.entities.push this


  tick: ->


  update: (room) ->
    if @model
      if !@threeObject
        @threeObject = @model.clone()
        room.add @threeObject

      @threeObject.position.x = 10*@x
      @threeObject.position.z = 10*@y


  cleanup: ->

  remove: ->
    if @threeObject
      Game.renderer.room.remove @threeObject
    this.cleanup()
    Game.state.entities = Game.state.entities.filter((entity) -> this != entity)

  onClick: ->
