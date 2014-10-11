class Desk
  @model: null
  constructor: (@x, @y) ->
    if !@model
      @model = ThreejsGameRenderer.getModel('small_desk')

  threeobject: null
  x: 0
  y: 0

  update: (scene, state) ->
    if !@threeobject
      @threeobject = @model.clone()
      scene.add @threeobject

    @threeobject.position.x = 10*@x
    @threeobject.position.z = 10*@y

  remove: (scene) ->
    scene.remove @threeobject
