class Entity
  x: 0
  y: 0

  collidable: true

  @model: null
  threeObject: null
  modelName: -> null

  constructor: (@x, @y) ->
    for entity in Game.state.entities
      if (@x and @y) and (entity.checkCollides(this) or this.checkCollides(entity))
        return null

    if !@model and this.modelName()
      @model = GameRenderer.getModel(this.modelName())
    Game.state.entities.push this
    Game.renderer.update()


  checkCollides: (other) ->
    return true if this.collidable and other.collidable and this.x == other.x and this.y == other.y


  update: (room) ->
    if @model
      if !@threeObject
        @threeObject = @model.clone()
        room.add @threeObject

      @threeObject.position.x = 10*@x
      @threeObject.position.z = 10*@y
  tick: ->
  onClick: ->
  cleanup: ->
  remove: ->
    if @threeObject
      Game.renderer.room.remove @threeObject
    this.cleanup()
    self = this
    Game.state.entities = Game.state.entities.filter((entity) -> self != entity)
