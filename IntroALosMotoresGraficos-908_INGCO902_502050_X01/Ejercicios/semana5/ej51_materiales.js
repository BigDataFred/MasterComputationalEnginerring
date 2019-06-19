////////////////////////////////////////////////////////////////////////////////
// Ejercicio 5.1. Materiales

var camera, scene, renderer;
var cameraControls;
var clock = new THREE.Clock();

var obj; // the object

var effectController;

function init() {
    var canvasWidth = window.innerWidth * 0.9;
    var canvasHeight = window.innerHeight * 0.9;
    var canvasRatio = canvasWidth / canvasHeight;

    camera = new THREE.PerspectiveCamera( 45, window.innerWidth / window.innerHeight, 0.1, 80000 );
    camera.position.set(0,0,10);
    camera.lookAt(0,0,-5);

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

function fillScene() {
    scene = new THREE.Scene();

    // LIGHTS

    var ambientLight = new THREE.AmbientLight( 0x101010 );
    var light = new THREE.DirectionalLight( 0x808080, 0.7 );
    light.position.set( 0, 1, 1 );
    var light2 = new THREE.DirectionalLight( 0x101010, 0.7 );
    light2.position.set( 0, -1, 0 );
    scene.add( ambientLight );
    scene.add( light );
    scene.add( light2 );

    // Initial material
    var material = new THREE.MeshBasicMaterial( { color : 0xFF0000} );

    // load suzanne
    loader = new THREE.JSONLoader;
    loader.load('suzanne.json', function(geom) {
        geom.dynamic = true;
        obj = new THREE.Mesh(
            geom,
            material);
        obj.rotation.y += Math.PI;
        scene.add(obj);
    });
}

function setupGui() {

    effectController = {
        Red:   0.98,
        Green: 0.01,
        Blue:  0.01,
        Model: 'Basic',
        Shading: 'Smooth',
        Shininess: 180.0,
        Wireframe: false
    };

    var gui = new dat.GUI();

    gui.add( effectController, "Red", 0.0, 1.0, 0.1 ).onChange(setMaterialParameters);
    gui.add( effectController, "Green", 0.0, 1.0, 0.1 ).onChange(setMaterialParameters);
    gui.add( effectController, "Blue", 0.0, 1.0, 0.1 ).onChange(setMaterialParameters);
    gui.add( effectController, "Model", ['Basic', 'Lambert', 'Phong'] ).onChange(setMaterial);
    gui.add( effectController, "Shininess", 0.0, 400, 1.0 ).onChange(setMaterialParameters);
    gui.add( effectController, "Shading", ['Flat', 'Smooth'] ).onChange(setMaterialParameters);
    gui.add( effectController, "Wireframe" ).onChange(setMaterialParameters);
}


function setMaterialParameters() {

    var material = obj.material; // get material from object

    var matColor = new THREE.Color(effectController.Red, effectController.Green, effectController.Blue);

    // TODO
    //
    // Change material color with matColor
    // 
    // use
    material.color = matColor;



    // TODO
    //
    // Check effectController.Shading value.
    //
    // possible values of effectController.Shading are: 'Flat','Smooth'
    //
    // use
	if ( effectController.Shading == 'Flat' ){
		material.shading = THREE.FlatShading;
	}
	else {
		material.shading = THREE.SmoothShading;
	}
    //
    // possible values are THREE.FlatShading and THREE.SmoothShading



    // TODO
    //
    // Check effectController.Wireframe (boolean)
    //
    // use
    //   material.wireframe = ...
    //
    // possible values are true/false
	if ( effectController.Wireframe == true){
		material.wireframe = true;
	}
	else {
		material.wireframe = false;
	}

    // TODO
    //
    // Set material shininess (only if material is Phong)
    //
    // use
    //   material.shininess = ...
	console.log(material.type);
	if (material.type == 'MeshPhongMaterial' ){
		material.shininess = effectController.Shininess;
		console.log(material.shininess);
	}

    obj.geometry.normalsNeedUpdate = true;
    material.needsUpdate = true;
}

function setMaterial() {

    var newMaterial;

    // TODO
    //
    // Create new material according to effectController.Model
    //
    // possible values of effectController.Model are: 'Basic', 'Lambert', 'Phong'
    // possible materials are: THREE.MeshBasicMaterial( ), THREE.MeshLambertMaterial( ), THREE.MeshPhongMaterial( )
    //
    // Example:
    //   newMaterial = new THREE.MeshBasicMaterial( );
    //   ...
	if ( effectController.Model == 'Basic' )
	{
		newMaterial = new THREE.MeshBasicMaterial( );
	}
	else if ( effectController.Model == 'Lambert' )
	{
		newMaterial = new THREE.MeshLambertMaterial( );
	}
	else 
	{
		newMaterial = new THREE.MeshPhongMaterial( );		
	}

    if (newMaterial) obj.material = newMaterial; // set new material to object
    setMaterialParameters();    // put proper values
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