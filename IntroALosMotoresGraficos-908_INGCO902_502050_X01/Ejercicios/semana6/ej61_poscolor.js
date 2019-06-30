////////////////////////////////////////////////////////////////////////////////
// Shader poscolor
//
// Do nothing here
//

var camera, scene, renderer;
var cameraControls;
var clock = new THREE.Clock();
var ambientLight, light;

function init() {
    var canvasWidth = window.innerWidth * 0.9;
    var canvasHeight = window.innerHeight * 0.9;
    var canvasRatio = canvasWidth / canvasHeight;

    camera = new THREE.PerspectiveCamera( 45, window.innerWidth / window.innerHeight, 1, 80000 );
    camera.position.set(0,0, 5);
    camera.lookAt(0,0,0);

    // renderer
    renderer = new THREE.WebGLRenderer( { antialias: true } );
    renderer.setSize( canvasWidth, canvasHeight );
    renderer.setClearColor( 0xAAAAAA, 1.0 );

    // Add to DOM
    var container = document.getElementById('container');
    container.appendChild( renderer.domElement );

    // controls
    cameraControls = new THREE.OrbitControls( camera, renderer.domElement );
    cameraControls.target.set(0, 0, 0);
}

function createShaderMaterial() {

    var material = new THREE.ShaderMaterial( {
        vertexShader: document.getElementById( 'vertexShader' ).textContent,
        fragmentShader: document.getElementById( 'fragmentShader' ).textContent
    } );
    return material;
}

function fillScene() {
    scene = new THREE.Scene();

    // Create the sphere

    var sphere_geom = new THREE.SphereGeometry( 1, 64, 32 );
    var shaderMaterial = createShaderMaterial();
    var sphere = new THREE.Mesh( sphere_geom,
                                 shaderMaterial );
    scene.add( sphere );
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