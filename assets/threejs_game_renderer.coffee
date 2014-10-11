class ThreejsGameRenderer
  tilesize: 20


  tile2coord: (x, y) ->
    new THREE.Vector3(x * @tilesize, 0, y * @tilesize)


  setup: (state) ->
    dw = window.innerWidth
    dh = window.innerHeight
    aspect = dw / dh
    d = 230

    @camera = new THREE.OrthographicCamera(-d*aspect, d*aspect, d, -d, 1, 4000);
    @camera.position.set( d, d, d );
    @camera.rotation.order = 'YXZ';
    @camera.rotation.y = - Math.PI / 4;
    @camera.rotation.x = Math.atan( -1 / Math.sqrt(2) );

    if (window.WebGLRenderingContext)
      try
        @threerenderer = new THREE.WebGLRenderer();
      catch error
        @threerenderer = new THREE.CanvasRenderer();
    else
      @threerenderer = new THREE.CanvasRenderer();

    @threerenderer.setSize(dw, dh);
    document.body.appendChild(@threerenderer.domElement);

    controls = new THREE.OrbitControls(@camera, @threerenderer.domElement)
    controls.noZoom = true;
    controls.noPan  = true;
    controls.maxPolarAngle = Math.PI / 2;
    #controls.zoomSpeed = 0.1;

    this.update(state)





  update: (state) ->
    level = state.level

    @scene = new THREE.Scene()

    # Lighting
    @scene.add new THREE.AmbientLight(0x444444)
    light = new THREE.PointLight(0xffffff, 0.8)
    light.position.set(0, 50, 50);
    @scene.add light

    # Axis marker
    @scene.add new THREE.AxisHelper(40)


    # Floor
    #geometry = new THREE.BoxGeometry(level.width * @tilesize, 20, level.height * @tilesize)
    #material = new THREE.MeshNormalMaterial()
    #@floor = new THREE.Mesh(geometry, material)
    #@scene.add @floor

    # Desk
    @scene.add this.makeDesk()


  makeDesk: ->
    desk = new THREE.Object3D()

    material = new THREE.MeshNormalMaterial()


    geometry = new THREE.BoxGeometry(0.9*@tilesize, 0.1*@tilesize, 0.9*@tilesize)
    desktop = new THREE.Mesh(geometry, material)
    desktop.position.y = @tilesize
    desk.add desktop



    desk



  render: (state) ->
    window.requestAnimationFrame($.proxy(this.render, this, state))

    this.update(state) # technically, we only need to do this if the scene has changed, not every frame.
    @threerenderer.render( @scene, @camera );
