class Floor extends Entity
  collidable: false
  constructor: ->
    if !@model
      floorcontainer = new THREE.Object3D()

      geometry = new THREE.BoxGeometry(Game.state.levelWidth*10, 10, Game.state.levelHeight*10)
      material = new THREE.MeshPhongMaterial({color: 0xadbeef})
      floor   = new THREE.Mesh(geometry, material)
      floor.position.x = Game.state.levelWidth * 5
      floor.position.y = -5
      floor.position.z = Game.state.levelHeight * 5
      floorcontainer.add floor

      # Draw a grid on the floor
      geometry = new THREE.Geometry()
      material = new THREE.LineBasicMaterial({vertexColors: THREE.VertexColors})
      color    = new THREE.Color(0x444444)
      for i in [0..(Game.state.levelHeight*10)] by 10
        geometry.vertices.push(
          new THREE.Vector3(0, 0, i), new THREE.Vector3(Game.state.levelWidth*10, 0, i)
        )
        geometry.colors.push(color, color)
      for i in [0..(Game.state.levelWidth*10)] by 10
        geometry.vertices.push(
          new THREE.Vector3(i, 0, 0), new THREE.Vector3(i, 0, Game.state.levelHeight*10)
        )
        geometry.colors.push(color, color)
      grid = new THREE.Line(geometry, material, THREE.LinePieces)
      grid.position.y += 0.1
      floorcontainer.add grid

      @model = floorcontainer

    super(0, 0)

  checkCollides: (other) ->
    return false

  onClick: (data) ->
    x = Math.floor((data.point.x + Game.state.levelWidth*5 )/10)
    y = Math.floor((data.point.z + Game.state.levelHeight*5)/10)
    if x < Game.state.levelWidth and y < Game.state.levelHeight
      this.tileClicked(x, y)


  tileClicked: (x, y) ->
    #return new SmallDesk(x,y)

    if Game.state.money > 500 and confirm("Do you want to add a desk for $500?")
      new SmallDesk(x, y)
      Game.state.money -= 500
