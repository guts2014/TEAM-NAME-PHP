class Renderable
  @model: null
  modelName: ->
    'renderable'
  constructor: (@x, @y) ->
    if !@model
      @model = ThreejsGameRenderer.getModel(this.modelName())

  threeobject: null
  x: 0
  y: 0

  update: (room, state) ->
    if !@threeobject
      @threeobject = @model.clone()
      room.add @threeobject

    @threeobject.position.x = 10*@x
    @threeobject.position.z = 10*@y

  remove: (room) ->
    room.remove @threeobject
