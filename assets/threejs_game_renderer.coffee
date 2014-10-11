class ThreejsGameRenderer
  movableItems: []

  models: {
    'small_desk': null,
    'large_desk': null
  }
  loadModels: ->
    console.log('loadModels()')
    loader = new THREE.ObjectLoader()
    self = this
    for name of @models
      f = ->
        name_ = name
        $.ajax('assets/models/'+name_+'.json').done((data)->
          self.models[name_] = loader.parse(data)
        )
      f()


  setup: (state) ->
    this.loadModels()

    dw = window.innerWidth
    dh = window.innerHeight
    aspect = dw / dh
    d = 180

    @camera = new THREE.OrthographicCamera(-d*aspect, d*aspect, d, -d, 1, 4000)
    @camera.position.set(d, d, d)
    @camera.rotation.order = 'YXZ'
    @camera.rotation.y = - Math.PI / 4
    @camera.rotation.x =   Math.atan(-1 / Math.sqrt(2))

    if (window.WebGLRenderingContext)
      try
        @threeRenderer = new THREE.WebGLRenderer()
      catch error
        @threeRenderer = new THREE.CanvasRenderer()
    else
      @threeRenderer = new THREE.CanvasRenderer()

    @threeRenderer.setSize(dw, dh)
    document.body.appendChild(@threeRenderer.domElement)


    # Controls
    controls = new THREE.OrbitControls(@camera, @threeRenderer.domElement)
    controls.noZoom = true
    controls.noPan  = false
    controls.noRotate = true
    controls.maxPolarAngle = Math.PI / 2
    #controls.zoomSpeed = 0.1


    # Create scene
    @scene = new THREE.Scene()

    # Lighting
    @scene.add new THREE.AmbientLight(0x444444)
    light = new THREE.PointLight(0xffffff, 0.8)
    light.position.set(0, 50, 50)
    @scene.add light

    # Axis marker
    @scene.add new THREE.AxisHelper(40)

    # Add the floor
    geometry = new THREE.BoxGeometry(state.level.width*10, 10, state.level.height*10)
    material = new THREE.MeshNormalMaterial()
    @floor   = new THREE.Mesh(geometry, material)
    @floor.position.x = state.level.width * 5
    @floor.position.y = -5
    @floor.position.z = state.level.height * 5
    @scene.add @floor

    # Add/update all the movable stuff
    this.update(state)


    # Correctly handle resizing windows
    onWindowResize = ->
      @camera.aspect = window.innerWidth / window.innerHeight
      @camera.updateProjectionMatrix()
      @threeRenderer.setSize(window.innerWidth, window.innerHeight)
    window.addEventListener 'resize', $.proxy(onWindowResize, this)


  update: (state) ->
    for movableItem in @movableItems
      movableItem.update(@scene, state)





  render: (state) ->
    window.requestAnimationFrame($.proxy(this.render, this, state))

    this.update(state) # technically, we only need to do this if the scene has changed, not every frame.
    @threeRenderer.render( @scene, @camera )
