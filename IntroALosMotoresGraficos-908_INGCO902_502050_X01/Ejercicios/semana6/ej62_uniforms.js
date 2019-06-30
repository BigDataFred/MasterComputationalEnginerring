////////////////////////////////////////////////////////////////////////////////
// Shader uniform
//
// set a uniform from a gui controller
//

var camera, scene, renderer;
var cameraControls;
var clock = new THREE.Clock();
var effectController;

var obj; // the object

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

    // TODO
    // add the following uniform variables:
    //
    // uColor: color of object (type: 'c'). Assign an initial value with a
    //         THREE.Color with color yellow (0xffff00)
    //
    // uFactor: a size factor (type 'f'). Assign a value of 1.0.

    var material =  new THREE.ShaderMaterial( {
		
		uniforms: {
			uFactor: { type: 'f', value: 1.0 },
			uColor: { type:'c', value: new THREE.Color( 0xffff00 ) }
			},
			
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
    obj = new THREE.Mesh( sphere_geom,
                          shaderMaterial );
    scene.add( obj );
}

function setupController() {

    effectController = {
        Red:   0.98,
        Green: 0.98,
        Blue:  0.01,
        Factor: 1.0
    };

    var h;

    var gui = new dat.GUI();

    gui.add( effectController, "Red", 0.0, 1.0, 0.1 ).onChange(setUniforms);
    gui.add( effectController, "Green", 0.0, 1.0, 0.1 ).onChange(setUniforms);
    gui.add( effectController, "Blue", 0.0, 1.0, 0.1 ).onChange(setUniforms);
    gui.add( effectController, "Factor", 0.0, 2.0, 0.1 ).onChange(setUniforms);
}


function setUniforms() {

    var shaderUniforms = obj.material.uniforms;
    // TODO
    // set the uniforms 'uColor' and 'uFactor' according to effectController
	
	var tmp1 = new THREE.Color().setRGB( effectController.Red, effectController.Green, effectController.Blue );
	console.log( shaderUniforms.uColor.value );
	shaderUniforms.uColor.value.copy(tmp1);
	
	var tmp2 = effectController.Factor;
	console.log( shaderUniforms.uFactor.value );
	shaderUniforms.uFactor.value = tmp2;
	
}

function animate() {
    window.requestAnimationFrame( animate );
    render();
}

function render() {
    var delta = clock.getDelta();
    cameraControls.update(delta);
    // render the scene
    renderer.render( scene, camera );
}

try {
    init();
    fillScene();
    setupController();
    animate();
} catch(e) {
    var errorReport = "Your program encountered an unrecoverable error, can not draw on canvas. Error was:<br/><br/>";
    $('#container').append(errorReport+e);
}