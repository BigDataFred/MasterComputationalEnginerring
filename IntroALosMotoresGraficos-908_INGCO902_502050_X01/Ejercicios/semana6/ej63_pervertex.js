////////////////////////////////////////////////////////////////////////////////
// Create custom material with shader
//

var camera, scene, renderer;
var cameraControls;
var clock = new THREE.Clock();
var effectController;

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

    // TODO:
    //
    // add the following uniform variables:
    //
    // uMaterialColor: the material color (type 'c'):
    //        Assign an initial value with a THREE.Color with color green
    //        (0x00ff00)
    //
    // uKd: the diffuse component (type 'f').
    //        Assign a value of 0.7.
    //
    // uKs: the specular component (type 'f').
    //        Assign a value of 0.7.
    //
    // uShininess: the material shininess (type 'f').
    //        Assign a value of 60.
    //
    // uLightAmbientColor: the ambient light color (type: 'c').
    //         Assign an initial value with a THREE.Color with color grey
    //         (0x202020)
    //
    // uLightDirection the direction of the light in camera space (type
    // 'v3')
    //         Assign an initial value of (0.0, 0.5, -0.3)
    //
    // uLightColor: the color of the light.
    //         Assign an initial value with a THREE.Color with color white
    //         (0xFFFFFF)

    var shaderMaterial = new THREE.ShaderMaterial( {
		uniforms: {
			uMaterialColor: { type: 'c', value: new THREE.Color( 0x00ff00 ) },
			uKd: { type:'f', value:0.7 },
			uKs: {type: 'f', value:0.7},
			uShininess: {type: 'f', value:60},
			uLightAmbientColor: {type: 'c', value: new THREE.Color(0x202020) },
			uLightDirection: {type: 'v3', value: new THREE.Vector3(0.0, 0.5, -0.3) },
			uLightColor: {type:'c', value: new THREE.Color(0xFFFFFF) }
		},
        vertexShader: document.getElementById( 'vertexShader' ).textContent,
        fragmentShader: document.getElementById( 'fragmentShader' ).textContent
    } );
    return shaderMaterial;
}

function fillScene() {
    scene = new THREE.Scene();

    // Create the sphere

    var sphere_geom = new THREE.SphereGeometry( 1, 64, 32 );
    var shaderMaterial = createShaderMaterial();
    var suzanne;
    loader = new THREE.JSONLoader;
    loader.load('suzanne.json', function(geom) {
        var suzanne = new THREE.Mesh(
            geom,
            shaderMaterial);
        suzanne.rotation.y -= 180 * Math.PI/180.0;
        scene.add(suzanne);
    });
}

function animate() {
    window.requestAnimationFrame( animate );
    render();
}

function render() {
    var delta = clock.getDelta();
    cameraControls.update(delta);

    var myColor = new THREE.Color(1.0, 0.0, 1.0);
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
