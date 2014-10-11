class ThreejsGameRenderer
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

  setup: (state) ->
    dw = window.innerWidth
    dh = window.innerHeight
    aspect = dw / dh
    d = 140

    @camera = new THREE.OrthographicCamera(-d*aspect, d*aspect, d, -d, 0.1, 1000)
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
    controls.noRotate = false
    controls.maxPolarAngle = Math.PI / 2
    #controls.zoomSpeed = 0.1


    # Create scene
    @scene = new THREE.Scene()



    # Lighting
    #@scene.add new THREE.AmbientLight(0x444444)
    light = new THREE.PointLight(0xffffff, 0.8)
    light.position.set(d, d, d)
    @scene.add light



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
    for desk in state.level.desks
      desk.update @scene, state





  render: (state) ->
    window.requestAnimationFrame($.proxy(this.render, this, state))

    this.update(state) # technically, we only need to do this if the scene has changed, not every frame.
    @threeRenderer.render( @scene, @camera )
