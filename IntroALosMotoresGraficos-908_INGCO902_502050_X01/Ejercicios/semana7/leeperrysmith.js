////////////////////////////////////////////////////////////////////////////////
// Chapel textures

var camera, scene, renderer;
var cameraControls;
var clock = new THREE.Clock();

var obj;

function init() {
    var canvasWidth = window.innerWidth * 0.9;
    var canvasHeight = window.innerHeight * 0.9;
    var canvasRatio = canvasWidth / canvasHeight;

    camera = new THREE.PerspectiveCamera( 45, window.innerWidth / window.innerHeight, 1, 80000 );
    camera.position.set(0,0,10);
    camera.lookAt(0,0,0);

    // RENDERER
    renderer = new THREE.WebGLRenderer( { antialias: true } );
    renderer.setSize( canvasWidth, canvasHeight );
    renderer.setClearColor( 0xAAAAAA, 1.0 );

    renderer.gammaInput = true;
    renderer.gammaOutput = true;

    // add to DOM
    // Add to DOM
    var container = document.getElementById('container');
    container.appendChild( renderer.domElement );

    // CONTROLS
    cameraControls = new THREE.OrbitControls( camera, renderer.domElement );
    cameraControls.target.set(0, 0, 0);

}

function fillScene() {
    scene = new THREE.Scene();
    //scene.fog = new THREE.Fog( 0x808080, 2000, 4000 );

    // LIGHTS

    ambientLight = new THREE.AmbientLight( 0x808080 );

    light = new THREE.DirectionalLight( 0xFFFFFF, 1 );
    light.position.set( 0, 0.5, -0.3 );

    scene.add( ambientLight );
    scene.add( light );

    var material = new THREE.MeshPhongMaterial( {
        color: 0xdddddd,
        specular: 0x222222,
        shininess: 35,
        map: THREE.ImageUtils.loadTexture( "images/obj/leeperrysmith/Map-COL.jpg" ),
        specularMap: THREE.ImageUtils.loadTexture( "images/obj/leeperrysmith/Map-SPEC.jpg" ),
        normalMap: THREE.ImageUtils.loadTexture( "images/obj/leeperrysmith/Infinite-Level_02_Tangent_SmoothUV.jpg" ),
        normalScale: new THREE.Vector2( 0.8, 0.8 )
    } );

    var loader = new THREE.JSONLoader();
    loader.load( "images/obj/leeperrysmith/LeePerrySmith.js", function( geometry ) {
        obj = new THREE.Mesh(geometry, material);
        scene.add(obj);
    })

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
    animate();
} catch(e) {
    var errorReport = "Your program encountered an unrecoverable error, can not draw on canvas. Error was:<br/><br/>";
    $('#container').append(errorReport+e);
}