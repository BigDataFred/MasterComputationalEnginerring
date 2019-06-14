// primer ejercicio con three.js
// crear una geometria teniendo en cuenta el orden de los vértices
var camera, scene, renderer;
var camera_v;
var handcamera;
var camNew;
var cameraControls;
var controlValores;
var clock = new THREE.Clock();
var ambientLight, light;

var R = new THREE.Vector3(1,0,0);  // los ejes del sistema de referencia de la cámara
var U = new THREE.Vector3(0,1,0);  //   coordenadas en el sistema de referencia del mundo
var D = new THREE.Vector3(0,0,1);  //  Right, Up y Deep
var E = new THREE.Vector3(0,0,2); // posicion camara
var at = new THREE.Vector3(0,0,0);  // punto al que mira

var campos, camat, camsobre, camright, camback; 
var pir_lines;  //el objeto que se coloca en frente de la cámara
var camara_actual =0;
var modo_vuelo = 0;  //analisis --> 0 
var speed = 1;
var mimatriz = new THREE.Matrix4();
var rangulo=0.1;



function pitch() // rotación es respecto a R 
{
// TODO
var auxmat = new THREE.Matrix4();
var angulo;
if (controlValores.Pitch > 0) angulo = rangulo;
	else angulo = -rangulo;
if (modo_vuelo === 0)
	{
	// modificar parametros de forma que el punto de atención no se mueva
	// la rotación es respecto a R 
	}
    else
	{
	// modificar parametros de forma que la posición de la cámara no se mueva
	// la rotación es respecto a R
	}
}

function yaw() // rotación es respecto a U
{
// TODO
var auxmat = new THREE.Matrix4();
var angulo;
if (controlValores.Yaw > 0) angulo = rangulo;
	else angulo = -rangulo;

if (modo_vuelo === 0)
	{
	// modificar parametros de forma que el punto de atención no se mueva
	// la rotación es respecto a U
	}
    else
	{
	// modificar parametros de forma que la posición de la cámara no se mueva
	// la rotación es respecto a U
	} 

renovar_camara();
}

function roll() //  rotación es respecto a D
{
// TODO

var auxmat = new THREE.Matrix4();
var angulo;
if (controlValores.Roll > 0) angulo = rangulo;
	else angulo = -rangulo;
if (modo_vuelo === 0)
	{
	// modificar parametros de forma que el punto de atención no se mueva
	// la rotación es respecto a D
	}
    else
	{
	// modificar parametros de forma que la posición de la cámara no se mueva
	// la rotación es respecto a D
	} 
renovar_camara();
}

function set_speed()
{
speed = controlValores.Speed;
}

function setupGUI()
{
controlValores =
    {
    Pitch: 0.0,
    Yaw: 0.0,
    Roll: 0.0,
    Speed: 1.0
    };

var gui = new dat.GUI();

// parametros para obtener los ejes del sistema de referencia de la cámara

gui.add( controlValores, "Pitch", -5, 5 ).name( "Rotar sobre R" ).onChange( pitch );
gui.add( controlValores, "Yaw", -5, 5 ).name( "Rotar sobre U" ).onChange( yaw );
gui.add( controlValores, "Roll", -5, 5 ).name( "Rotar sobre Z" ).onChange( roll );
gui.add( controlValores, "Speed", -5, 5 ).name( "Speed" ).onChange( set_speed );
}

function cam(val)
{
if (val === 1) camera_v = camera;
    else camera_v = camNew; 
}


function modo(val)
{
if (val===1)
	{
	 modo_vuelo = 0;  // analisis
	alert(modo_vuelo);
	}
    else 
	{
	modo_vuelo = 1; 
	alert(modo_vuelo);
	}

}

function cambio_camara()
{
if (camara_actual===1)
	{ 
	camera_v = camera;
	camara_actual = 0;
	}
    else 
	{ 
	camera_v = camNew;
	camara_actual = 1;
	}
alert(camara_actual);
}
 
function init() {
	var canvasWidth = window.innerWidth * 0.9;
	var canvasHeight = window.innerHeight * 0.9;

	container = document.createElement('div');
	document.body.appendChild(container);

	var info = document.createElement('div');
	info.style.position = 'absolute';
	info.style.top = '10px';
	info.style.width = '100%';
	info.style.textAlign = 'center';
	info.innerHTML += 'control de cámara:<input id="analisis" type="button" onclick="modo(1)" value="analisis"/><input id="vuelo" type="button" onclick="modo(0)" value="vuelo"/><input id="camara" type="button" onclick="cambio_camara()" value="cambio cámara"/>';
	container.appendChild(info);


	
	// CAMERA

	camera = new THREE.PerspectiveCamera( 45, window.innerWidth / window.innerHeight, 1, 80000 );
	camera.position.set(-1,1,7);
	camera.lookAt(0,0,0);



	camNew = new THREE.PerspectiveCamera( 45, window.innerWidth / window.innerHeight, 1, 80000 );
	camNew.position.set(0,0,2);
	camNew.lookAt(0,0,0);
	// LIGHTS

	light = new THREE.DirectionalLight( 0xFFFFFF, 0.7 );
	light.position.set( 4, 4, 4 );
	light.target.position.set(0, 0, 0);
	light.target.updateMatrixWorld()

	var ambientLight = new THREE.AmbientLight( 0x111111 );

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

	// OBJECT
		
		// ejes del Sistema de Ref del mundo
	var M_line_material = new THREE.LineBasicMaterial({color: 0xff0000});

	var M_XYZgeometry = new THREE.Geometry();
	M_XYZgeometry.vertices.push(
	new THREE.Vector3( 1, 0, 0 ), // X
	new THREE.Vector3( 0, 0, 0 ), // O
	new THREE.Vector3( 0, 1, 0 ), // Y
	new THREE.Vector3( 0, 0, 0 ), // 0
	new THREE.Vector3( 0, 0, 1 ) // Z
);
	var M_ejes = new THREE.Line( M_XYZgeometry, M_line_material );
	
	var material = new THREE.MeshPhongMaterial( { color: 0xFff000 } ); // Material esfera
	var materialb = new THREE.MeshPhongMaterial( { color: 0x0000ff } ); 
	var miotrageometria= new THREE.SphereGeometry( 0.4, 64, 64 ); //BoxGeometry( 1, 1, 1 );
	var miotroobjeto = new THREE.Mesh (miotrageometria, material); 
	var camatgeometria= new THREE.SphereGeometry( 0.02, 32, 32 ); 
	var camgeometria= new THREE.SphereGeometry( 0.04, 32, 32 );

	campos = new THREE.Mesh (camgeometria, material); 
	camat = new THREE.Mesh (camatgeometria, materialb); 
	camsobre = new THREE.Mesh (camatgeometria, material); 
	camright = new THREE.Mesh (camatgeometria, material); 
	camback = new THREE.Mesh (camatgeometria, material);

	var yotroobjeto = new THREE.Mesh (miotrageometria, material); 
	// SCENE

	scene = new THREE.Scene();
	scene.add( light );
	scene.add( ambientLight );
	scene.add( campos ); 
	scene.add( camat );
	scene.add( camsobre ); 
	scene.add( camright );
	scene.add( camback );
	scene.add( M_ejes );
	scene.add( pir_lines );

	scene.add( miotroobjeto );
	scene.add( yotroobjeto );
	yotroobjeto.position.z = -2;

        setupGUI();
	//mostrar_consola();
	camera_v = camera;
	camara_actual = 0;
}

function animate() {
	window.requestAnimationFrame( animate );
	render();
}

function render() {
	var delta = clock.getDelta();
	cameraControls.update(delta);
	if (modo_vuelo === 1)
		{
		var vaux = new THREE.Vector3(D.x*0.01*speed,
					D.y*0.01*speed,
					D.z*0.01*speed);
		E.sub( vaux);
		at.sub ( vaux);
		console.log(E.z);
		}
	renovar_camara();
	renderer.render( scene, camera_v );
}

function renovar_camara()
{
camNew.position.copy(E);
camNew.up.copy(U);
camNew.lookAt(at);
campos.position.copy(E);
camat.position.copy(at);
camsobre.position.set(E.x+U.x, E.y+U.y, E.z+U.z); 
camright.position.set(E.x+R.x, E.y+R.y, E.z+R.z); 
camback.position.set(E.x+D.x, E.y+D.y, E.z+D.z);
}


try {
	init();
	animate();
} catch(e) {
	var errorReport = "Your program encountered an unrecoverable error, can not draw on canvas. Error was:<br/><br/>";
	$('#container').append(errorReport+e);
}

