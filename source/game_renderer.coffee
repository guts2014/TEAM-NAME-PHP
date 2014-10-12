class GameRenderer
  stats: new Stats()

  setup: ->
    @stats.setMode(0)
    @stats.domElement.style.position = 'absolute'
    @stats.domElement.style.right = '0px'
    @stats.domElement.style.top = '0px'
    document.body.appendChild(@stats.domElement)


    dw = window.innerWidth
    dh = window.innerHeight
    aspect = dw / dh
    d = 150

    @camera = new THREE.OrthographicCamera(-d*aspect, d*aspect, d, -d, -1000, 1000)
    @camera.position.set(d, d, d)
    @camera.rotation.order = 'YXZ'
    @camera.rotation.y = - Math.PI / 4
    @camera.rotation.x =   Math.atan(-1 / Math.sqrt(2))

    if window.WebGLRenderingContext
      try
        @threeRenderer = new THREE.WebGLRenderer()
      catch error
        @threeRenderer = new THREE.CanvasRenderer()
    else
      @threeRenderer = new THREE.CanvasRenderer()

    @threeRenderer.setClearColor(0xffffff, 1)
    @threeRenderer.setSize(dw, dh)
    document.body.appendChild(@threeRenderer.domElement)


    # Controls
    controls = new THREE.OrbitControls(@camera, @threeRenderer.domElement)
    controls.noZoom = true
    controls.noPan  = false
    controls.noRotate = false
    controls.maxPolarAngle = Math.PI / 2
    #controls.zoomSpeed = 0.1


    # Create scene
    @scene = new THREE.Scene()

    # Lighting
    @scene.add new THREE.AmbientLight(0x111111)
    @light = new THREE.PointLight(0xffffff, 0.7)
    @light.position.set(d, d, d)
    @scene.add @light


    # Create a room object and add it to the scene
    @room = new THREE.Object3D()
    @room.position.x = -Game.state.levelWidth*5
    @room.position.z = -Game.state.levelHeight*5
    @scene.add @room


    # Add the floor
    geometry = new THREE.BoxGeometry(Game.state.levelWidth*10, 10, Game.state.levelHeight*10)
    material = new THREE.MeshPhongMaterial({color: 0x00ff00})
    @floor   = new THREE.Mesh(geometry, material)
    @floor.position.x = Game.state.levelWidth * 5
    @floor.position.y = -5
    @floor.position.z = Game.state.levelHeight * 5
    @room.add @floor


    # Draw a grid on the floor
    geometry = new THREE.Geometry()
    material = new THREE.LineBasicMaterial({vertexColors: THREE.VertexColors})
    color    = new THREE.Color(0x666666)
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
    @grid = new THREE.Line(geometry, material, THREE.LinePieces)
    @grid.position.y += 0.1
    @room.add @grid

    # Add/update all the movable stuff
    this.update()


    # Correctly handle resizing windows
    onWindowResize = ->
      dw = window.innerWidth
      dh = window.innerHeight
      aspect = dw / dh
      d = 150
      @threeRenderer.setSize(dw, dh)
      @camera.position.set(d, d, d)
      @camera.left   = -d*aspect
      @camera.right  =  d*aspect
      @camera.top    =  d
      @camera.bottom = -d
      @camera.updateProjectionMatrix()
    window.addEventListener 'resize', $.proxy(onWindowResize, this)

    # Entity Click Detection
    onDocumentMouseDown = (event) ->
      event.preventDefault()
      if event.button is 0
        projector = new THREE.Projector()
        vector = new THREE.Vector3((event.clientX / window.innerWidth) * 2 - 1, -(event.clientY / window.innerHeight) * 2 + 1, 0.5)

        raycaster = projector.pickingRay(vector, @camera)

        getO3D = (ob) ->
          if !(ob instanceof THREE.Mesh)
            return ob
          else
            return getO3D(ob.parent)

        objects = []
        lut = {}
        for entity in Game.state.entities
          if entity.threeObject
            objects.push entity.threeObject
            lut[entity.threeObject.uuid] = entity
        intersectsObj = raycaster.intersectObjects(objects, true)
        if intersectsObj.length > 0
          data = intersectsObj[0]
          entity = lut[getO3D(data.object).uuid]
          entity.onClick()

      event = null
    document.querySelector('canvas').addEventListener 'mousedown', $.proxy(onDocumentMouseDown, this)


  update: ->
    $('#gamestate').html(Game.state.toString().replace(/\n/g, "<br />"))

    for entity in Game.state.entities
      entity.update @room


  render: ->
    window.requestAnimationFrame($.proxy(this.render, this))

    @stats.begin()
    @light.position.copy(@camera.position)
    @light.position.y += 100
    @threeRenderer.render( @scene, @camera )
    @stats.end()


  @models: {}
  @getModel: (name) ->
    if @models[name]
      return @models[name]
    else
      loader = new THREE.ObjectLoader()
      data = {}
      jQuery.ajax({
        url:    'assets/models/'+name+'.json',
        success: (result) ->
          data = result
        async:   false
      });
      model = loader.parse(data)
      @models[name] = model
      return model
