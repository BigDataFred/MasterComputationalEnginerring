////////////////////////////////////////////////////////////////////////////////
// Set aliasing filters and ST wrapping

var camera, scene, renderer;
var cameraControls;
var clock = new THREE.Clock();

var squareGeometry; // the geometry
var obj; // the object

var Images = {}; // hash with all the textures
var effectController;

function init() {
    var canvasWidth = window.innerWidth * 0.9;
    var canvasHeight = window.innerHeight * 0.9;
    var canvasRatio = canvasWidth / canvasHeight;

    camera = new THREE.PerspectiveCamera( 45, window.innerWidth / window.innerHeight, 0.1, 80000 );
    camera.position.set(0,0,12);
    camera.lookAt(0,0,0);

    // RENDERER
    renderer = new THREE.WebGLRenderer( { antialias: true } );
    renderer.setSize( canvasWidth, canvasHeight );
    renderer.setClearColor( 0xAAAAAA, 1.0 );

    renderer.gammaInput = true;
    renderer.gammaOutput = true;

    // Add to DOM
    var container = document.getElementById('container');
    container.appendChild( renderer.domElement );

    // CONTROLS
    cameraControls = new THREE.OrbitControls( camera, renderer.domElement );
    cameraControls.target.set(0, 0, 0);
}

function loadTexture(name) {
    var tex = THREE.ImageUtils.loadTexture( name );
    // initial antialias filter
    tex.magFilter = THREE.NearestFilter;
    tex.minFilter = THREE.NearestFilter;
    tex.generateMipmaps = false;
    return tex;
}

function loadTextures() {

    Images['2'] = loadTexture("images/check2x2.png" );
    Images['4'] = loadTexture("images/check4x4.png" );
    Images['8'] = loadTexture("images/check8x8.png" );
    Images['16'] = loadTexture("images/check16x16.png" );
    Images['32'] = loadTexture("images/check32x32.png" );
    Images['64'] = loadTexture("images/check64x64.png" );
    Images['128'] = loadTexture("images/check128x128.png" );
    Images['256'] = loadTexture("images/check256x256.png" );
    Images['UV'] = loadTexture("images/uvgrid.jpg" );
    Images['R'] = loadTexture("images/r_border.png" );
    Images['pluma'] = loadTexture("images/feather.png" );
    Images['hierba'] = loadTexture("images/grass512x512.jpg" );
}

function createSquareGeometry(side, u, v) {
    squareGeometry = new THREE.Geometry();
    squareGeometry.dynamic = true;
    var hside = Math.floor(side/2.0);
    //var hside = side;

    // generate vertices
    squareGeometry.vertices.push( new THREE.Vector3( -hside, -hside, 0.0 ));
    squareGeometry.vertices.push( new THREE.Vector3(  hside, -hside, 0.0 ));
    squareGeometry.vertices.push( new THREE.Vector3(  hside,  hside, 0.0 ));
    squareGeometry.vertices.push( new THREE.Vector3( -hside,  hside, 0.0 ));

    var uvs = [];
    uvs.push( new THREE.Vector2( 0.0, 0.0 ) );
    uvs.push( new THREE.Vector2( u, 0.0 ) );
    uvs.push( new THREE.Vector2( u, v ) );
    uvs.push( new THREE.Vector2( 0.0, v ) );

    // generate faces
    squareGeometry.faces.push( new THREE.Face3( 0, 1, 2 ) );
    squareGeometry.faceVertexUvs[ 0 ].push( [ uvs[0], uvs[1], uvs[2] ] );
    squareGeometry.faces.push( new THREE.Face3( 0, 2, 3 ) );
    squareGeometry.faceVertexUvs[ 0 ].push( [ uvs[0], uvs[2], uvs[3] ] );
}

function fillScene() {
    scene = new THREE.Scene();

    var ambientLight = new THREE.AmbientLight( 0xFFFFFF );
    var light = new THREE.DirectionalLight( 0xFFFFFF, 0.7 );
    light.position.set( 0, 0.5, -0.3 );
    scene.add( ambientLight );
    scene.add( light );

    loadTextures();
    createSquareGeometry(10, 1, 1);
    var texture = Images['R'];
    var material = new THREE.MeshPhongMaterial( { color : 0xFFFFFF,
                                                  side:THREE.DoubleSide,
                                                  map: texture });
    obj = new THREE.Mesh(squareGeometry, material);
    scene.add(obj);
}

function setUVs() {

    var u = effectController.U;
    var v = effectController.V;
    var uvs = [];
    uvs.push( new THREE.Vector2( 0.0, 0.0 ) );
    uvs.push( new THREE.Vector2( u, 0.0 ) );
    uvs.push( new THREE.Vector2( u, v ) );
    uvs.push( new THREE.Vector2( 0.0, v ) );

    squareGeometry.faceVertexUvs[ 0 ].pop();
    squareGeometry.faceVertexUvs[ 0 ].pop();
    squareGeometry.faceVertexUvs[ 0 ].push( [ uvs[0], uvs[1], uvs[2] ] );
    squareGeometry.faceVertexUvs[ 0 ].push( [ uvs[0], uvs[2], uvs[3] ] );
    squareGeometry.uvsNeedUpdate = true;
}

function setImage() {
    obj.material.map = Images[effectController.image];
    setMipmap();
    setWrap();
}

function setMipmap() {

    var texture = obj.material.map;
    texture.generateMipmaps = effectController.mipmap;
    setFilters();
}

function setFilters() {

    var texture = obj.material.map;

    setMagFilters(texture);
    if (effectController.mipmap) setMinMipmapFilters(texture);
    else setMinFilters(texture);

    texture.needsUpdate = true;
}

function setMagFilters(texture) {

    // TODO: set magnification filter of texture
    //
    // check effectController.magnification
    //
    // possible values: 'Nearest', 'Linear'
    //
    // set
    //  texture.magFilter = ...
    //
    // possible values: THREE.NearestFilter, THREE.LinearFilter
    console.log(effectController.magnification);
	if (effectController.magnification == "Nearest"){
		texture.magFilter = THREE.NearestFilter;
	} else{
		texture.magFilter = THREE.LinearFilter;
	}
	
    texture.needsUpdate = true;

}

function setMinFilters(texture) {

    // TODO: set minification filter of texture (no mipmap)
    //
    // check effectController.minification
    //
    // possible values: 'Nearest', 'Linear'
    //
    // set
    //  texture.minFilter = ...
    //
    // possible values: THREE.NearestFilter, THREE.LinearFilter
	console.log(effectController.minification);
	if (effectController.minification == "Nearest"){
		texture.minFilter = THREE.NearestFilter;
	} else{
		texture.minFilter = THREE.LinearFilter;
	}
    texture.needsUpdate = true;

}

function setMinMipmapFilters(texture) {

    // TODO: set minification filter of texture (mipmap)
    //
    // check effectController.mipFilter
    //
    // possible values: 'Linear/Linear', 'Nearest/Linear', 'Linear/Nearest', 'Nearest/Nearest'
    //
    // set
    //  texture.minFilter = ...
    //
    // possible values: THREE.LinearMipMapLinearFilter, THREE.NearestMipMapLinearFilter,
    //                  THREE.LinearMipMapNearestFilter, THREE.NearestMipMapNearestFilter
	console.log(effectController.mipFilter);
	if (effectController.mipFilter == "Linear/Linear"){
		texture.minFilter = THREE.LinearMipMapLinearFilter;
	} else if (effectController.mipFilter == "Nearest/Linear"){
		texture.minFilter = THREE.NearestMipMapLinearFilter;
	} else if (effectController.mipFilter == "Linear/Nearest"){
		texture.minFilter = THREE.LinearMipMapNearestFilter;
	} else{
		texture.minFilter = THREE.NearestMipMapNearestFilter;
	}
    texture.needsUpdate = true;

}

function setWrap() {

    var texture = obj.material.map;

    // TODO: set wrap (both wrapS and wrapT) of texture
    //
    // check effectController.wrap
    //
    // possible values: 'Clamp', 'Repeat', 'Mirror'
    //
    // set both:
    //  texture.wrapS = ...
    //  texture.wrapT = ...
    //
    // possible values: THREE.ClampToEdgeWrapping, THREE.RepeatWrapping, THREE.MirroredRepeatWrapping;
	
	console.log(effectController.wrap);
	if (effectController.wrap == "Clamp"){
    	texture.wrapS = THREE.ClampToEdgeWrapping;
    	texture.wrapT = THREE.ClampToEdgeWrapping;
	} else if (effectController.wrap == "Repeat") {
    	texture.wrapS = THREE.RepeatWrapping;
    	texture.wrapT = THREE.RepeatWrapping;
	}
	else{
    	texture.wrapS = THREE.MirroredRepeatWrapping;
    	texture.wrapT = THREE.MirroredRepeatWrapping;
	}
    texture.needsUpdate = true;
}

function setupGui() {

    effectController = {

        magnification: 'Nearest',
        minification: 'Nearest',
        mipmap: false,
        mipFilter: 'Nearest/Nearest',
        wrap: 'Clamp',
        U: 1,
        V: 1,
        image: 'R'
    };

    var gui = new dat.GUI();

    gui.add( effectController, "magnification", ['Nearest', 'Linear'] ).onChange(setFilters);
    gui.add( effectController, "minification", ['Nearest', 'Linear'] ).onChange(setFilters);
    gui.add( effectController, "mipmap").onChange(setMipmap);
    gui.add( effectController, "mipFilter", ['Nearest/Nearest', 'Nearest/Linear', 'Linear/Nearest', 'Linear/Linear'] ).onChange(setFilters);
    gui.add( effectController, "image", ['2', '4', '8', '16', '32', '64', '128', '256', 'UV', 'R', 'pluma', 'hierba'] ).onChange(setImage);
    gui.add( effectController, "wrap", ['Clamp', 'Repeat', 'Mirror'] ).onChange(setWrap);
    gui.add( effectController, "U", 1.0, 50.0, 1.0 ).onChange(setUVs);
    gui.add( effectController, "V", 1.0, 50.0, 1.0 ).onChange(setUVs);
}


function animate() {
    window.requestAnimationFrame( animate );
    render();
}

function render() {
    var delta = clock.getDelta();
    cameraControls.update(delta);
    renderer.render( scene, camera );
}

try {
    init();
    fillScene();
    setupGui();
    animate();
} catch(e) {
    var errorReport = "Your program encountered an unrecoverable error, can not draw on canvas. Error was:<br/><br/>";
    $('#container').append(errorReport+e);
}