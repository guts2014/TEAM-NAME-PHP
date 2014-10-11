class ThreejsGameRenderer
  models: {}

  setup: (state) ->
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

    controls = new THREE.OrbitControls(@camera, @threeRenderer.domElement)
    controls.noZoom = true
    controls.noPan  = false
    controls.noRotate = true
    controls.maxPolarAngle = Math.PI / 2
    #controls.zoomSpeed = 0.1

    this.update(state)

    loader = new THREE.STLLoader()

    handleLoadEvent = (event) ->
      geometry = event.content
      material = new THREE.MeshPhongMaterial( { ambient: 0xff5533, color: 0xff5533, specular: 0x111111, shininess: 200 } )
      mesh = new THREE.Mesh( geometry, material )

      mesh.position.set( 0, - 0.25, 0.6 )
      mesh.rotation.set( 0, - Math.PI / 2, 0 )
      mesh.scale.set( 0.5, 0.5, 0.5 )

      #@scene.add mesh
      console.log(mesh)

    loader.addEventListener 'load', handleLoadEvent
    loader.load 'assets/models/small_desk.stl'
    loader.load 'assets/models/large_desk.stl'



    onWindowResize = ->
      @camera.aspect = window.innerWidth / window.innerHeight
      @camera.updateProjectionMatrix()
      @threeRenderer.setSize(window.innerWidth, window.innerHeight)
    window.addEventListener 'resize', $.proxy(onWindowResize, this)





  update: (state) ->
    level = state.level

    @scene = new THREE.Scene()

    # Lighting
    @scene.add new THREE.AmbientLight(0x444444)
    light = new THREE.PointLight(0xffffff, 0.8)
    light.position.set(0, 50, 50)
    @scene.add light

    # Axis marker
    @scene.add new THREE.AxisHelper(40)


    # Floor
    geometry = new THREE.BoxGeometry(level.width*10, 10, level.height*10)
    material = new THREE.MeshNormalMaterial()
    @floor   = new THREE.Mesh(geometry, material)
    @floor.position.x = level.width * 5
    @floor.position.y = -5
    @floor.position.z = level.height * 5
    @scene.add @floor

    # Desk
    #@scene.add this.makeDesk()







  render: (state) ->
    window.requestAnimationFrame($.proxy(this.render, this, state))

    this.update(state) # technically, we only need to do this if the scene has changed, not every frame.
    @threeRenderer.render( @scene, @camera )
