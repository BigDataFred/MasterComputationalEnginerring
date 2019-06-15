////////////////////////////////////////////////////////////////////////////////
// Exercise 5.4. Spotlight

var camera, scene, renderer;
var cameraControls;
var clock = new THREE.Clock();
var ambientLight;

var obj;

function init() {
    var canvasWidth = window.innerWidth * 0.9;
    var canvasHeight = window.innerHeight * 0.9;

    // SCENE

    scene = new THREE.Scene();

    // CAMERA

    camera = new THREE.PerspectiveCamera( 45, window.innerWidth / window.innerHeight, 1, 80000 );
    camera.position.set(-2, 2, 3);
    camera.lookAt(0,0,0);

    // LIGHTS

    var ambientLight = new THREE.AmbientLight( 0x111111 );
    scene.add( ambientLight );


    // TODO:
    //
    // create a spotlight with the following values:
    //
    // color: full white
    // intensity: 1.5
    // location: -7, 7, 0.5
    // distance: 20
    // angle: 10 degrees (multiply with Math.PI/180 to have radians)
    // exponent: 1
    // decay: 1
    //
    // Also, add spotlight to the scene

    var spotlight = {};

    // Uncomment follow line to have the spotlight cast shadows
    // spotlight.castShadow = true;

    spotlight.shadowCameraNear = 1;
    spotlight.shadowCameraFar = 2500;
    spotlight.shadowCameraFov = 50;
    spotlight.shadowBias = 0.0001;
    spotlight.shadowDarkness = 0.5;
    spotlight.shadowMapWidth = 1024;
    spotlight.shadowMapHeight = 1024;

    // RENDERER
    renderer = new THREE.WebGLRenderer( { antialias: true } );
    renderer.setSize( canvasWidth, canvasHeight );
    renderer.setClearColor( 0xAAAAAA, 1.0 );

    renderer.gammaInput = true;
    renderer.gammaOutput = true;
    renderer.shadowMapEnabled = true;
    // CONTROLS
    cameraControls = new THREE.OrbitControls( camera, renderer.domElement );
    cameraControls.target.set(0, 0, 0);
}

function create_ground() {
    var planeGeometry = new THREE.PlaneGeometry( 10, 10 );
    var planeMaterial = new THREE.MeshPhongMaterial( { color: 0xffeeaa } );
    var ground = new THREE.Mesh( planeGeometry, planeMaterial );
    ground.rotation.x -= 90 * Math.PI/180;
    ground.position.y -= 1;
    ground.castShadow = false;
    ground.receiveShadow = true;
    return ground;
 }

function fillScene() {

    var ground = create_ground();
    scene.add( ground );
    loader = new THREE.JSONLoader();
    loader.load( 'suzanne.json', function ( geometry ) {
        obj = new THREE.Mesh( geometry,
                              new THREE.MeshPhongMaterial({ color: 0xF00000 }));
        obj.rotation.y += Math.PI/2;
        obj.position.y += 0.5;
        obj.scale.set(0.75, 0.75, 0.75);
        obj.castShadow = true;
        scene.add( obj );
    } );
}

function addToDOM() {
    var container = document.getElementById('container');
    var canvas = container.getElementsByTagName('canvas');
    if (canvas.length>0) {
        container.removeChild(canvas[0]);
    }
    container.appendChild( renderer.domElement );
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
    addToDOM();
    fillScene();
    animate();
} catch(e) {
    var errorReport = "Your program encountered an unrecoverable error, can not draw on canvas. Error was:<br/><br/>";
    $('#container').append(errorReport+e);
}