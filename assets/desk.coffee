class Desk
  @model: null
  constructor: (@pos_x, @pos_y) ->
    if !@model
      @model = window.game.renderer.models['small_desk'] # urgh, fix this mess.



  pos_x: 0
  pos_y: 0

  threeobject: null

  update: (scene, state) ->
    if !@threeobject
      @threeobject = @model.clone()
      scene.add @threeobject

    @threeobject.position.x = 10*@pos_x
    @threeobject.position.z = 10*@pos_y

  remove: (scene) ->
    scene.remove @threeobject
