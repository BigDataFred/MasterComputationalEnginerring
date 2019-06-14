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
var up = new THREE.Vector3(0,0,0);  // vector que indica verticalidad

var ejes; // el objeto de la escena que representa a la cámara, mediante líneas azules
var pir_lines;  //el objeto que se coloca en frente de la cámara

function mostrar_consola()
{

// posicion de la nueva camera (1)
E.x = controlValores.PX;
E.y=controlValores.PY;
E.z=controlValores.PZ;

// punto de atencion (2)
at.x=controlValores.aX;
at.y=controlValores.aY;
at.z=controlValores.aZ;

// verticalidad de la camera (3)
up.x=controlValores.UpX;
up.y=controlValores.UpY;
up.z=controlValores.UpZ;

console.log("estoy en = "+E.x+", " + E.y+", " +E.z);//position
console.log("    mirando a "+at.x+", " +at.y +", " +at.z);//mirando a

// TODO 1 recalcular las coordenadas de los ejes del sistema de referencia de la cámara
//	partiendo de la posición, punto al que mira y el vector up
//	dejar las coordenadas en los vectores R, U y D (Right, Up, Deep)


//Pasar Sistema referencia local a Sistema referencia mundo
var D = new THREE.Vector3(E.x-at.x,E.y-at.y,E.z-at.z);// posticion camera - punto donde camera esta mirando
D.normalize();// vector unitario

var R = new THREE.Vector3();
R.crossVectors(up,D);
R.normalize();// vector unitario

var U = new THREE.Vector3();
U.crossVectors(D,R);// ya es vector unitario

console.log("R = "+R.x+", " + R.y+", " +R.z);
console.log("U = "+U.x+", " + U.y+", " +U.z);
console.log("D = "+D.x+", " + D.y+", " +D.z);

// TODO 1: 
// recalcular las coordenadas del objeto que representa a la cámara en funcion de la posición de la cámara (variable E) y de los tres ejes de su sistema de referencia (variables R, U y D):
//	ejes.geometry.vertices[i]

//        vertice 0 ---> derecha de la cámara (eje X: posición ćamara + R)
ejes.geometry.vertices[0].addVectors(E,R);
//        1 ---> posición de la cámara
ejes.geometry.vertices[1].copy(E);
//        2 ---> encima de la cámara (eje Y)
ejes.geometry.vertices[2].addVectors(E,U);
//        3 ---> posición de la cámara
ejes.geometry.vertices[3].copy(E);
//        4 ---> en el eje Z de la cámara
ejes.geometry.vertices[4].addVectors(E,D);
//        5 ---> posición de la cámara
ejes.geometry.vertices[5].copy(E);
//        6 ---> delante de la cámara, y a la derecha (posición cámara - D + R)
ejes.geometry.vertices[6].set( E.x-D.x+R.x, E.y-D.y+R.y, E.z-D.z+R.z);
//        7 ---> delante de la cámara, y a la izquierda
ejes.geometry.vertices[7].set( E.x-D.x-R.x, E.y-D.y-R.y, E.z-D.z-R.z);
//        8 ---> posición de la cámara
ejes.geometry.vertices[8].copy(E);
/********/



/********/
ejes.geometry.verticesNeedUpdate=true;



// TODO 2: asignar a la cámara nueva camNew:
//	1.- la posición de la cámara
//	2.- el vector up
//	3.- La matriz de cambio de sistema de referencia mediante 
//	    el método lookAt asociado a las cámaras.
/***************/
camNew.position.copy(E);
camNew.up.copy( up );
camNew.lookAt( at );
camNew.updateMatrixWorld ( true );
/****************/


// TODO 3: asignar directamente las matrices a la cámara nueva camNew (set o copy o lo que sea)
//	pero para ello hay que comentar el código que se ha añadido para el ejercicio 2
// las matrices que hay que asignar son:
// 1.- camNew.matrix.  
// 2.- camNew.matrixWorld	Matriz que posiciona la cámara en el 
//				mundo. Estas dos matrices, en nuestro caso, son iguales,
//				y representan el cambio de sistema de referencia de
//				la cámara al sistema de referencia del mundo (local --> mundo)
// 3.- camNew.matrixWorldInverse   Matriz que pasa al sistema de referencia de la cámara
/**********/

// posicion (E)
// punto de atencion (at)
// verticalidad (up)

var W2L = new THREE.Matrix4(); // del mundo a la camera
W2L.set(
	R.x, 	R.y, 	R.z, 	-R.dot(E), 
	U.x, 	U.y, 	U.z, 	-U.dot(E),
	D.x, 	D.y, 	D.z, 	-D.dot(E),
	0,	0,	0,	1
);

var L2W = new THREE.Matrix4(); // de la camera al mundo
L2W.set(
	R.x, 	U.x, 	D.x, 	E.x, 
	R.y, 	U.y, 	D.y, 	E.y,
	R.z, 	U.z, 	D.z, 	E.z,
	0,	0,	0,	1	
	);

camNew.matrix.copy( L2W );
camNew.matrixWorld.copy( L2W );
camNew.matrixWorldInverse.copy( W2L );
camNew.updateMatrixWorld ( true );

/***********/


// TODO 3 hacer que el objeto pir_lines se mueva junto con la cámara, 
//     pero sin modificar las coordenadas de los vértices, modificando su matriz.
//     igual que en el TODO 2 para la función relolocar_pir.
//     Las matrices a modificar son: pir_lines.matrix y pir_lines.matrixWorld
/***************/

pir_lines.matrix.copy( camNew.matrixWorld );
pir_lines.matrixWorld.copy( camNew.matrixWorld );

/**************/

}



function setupGUI()
{

controlValores =
    {
    PX: 0.0,
    PY: 0.0,
    PZ: 2.0,
    aX: 0.0,
    aY: 0.0,
    aZ: 0.0,
    UpX: 0.0,
    UpY: 1.0,
    UpZ: 0.0
    };

var gui = new dat.GUI();

// parametros para obtener los ejes del sistema de referencia de la cámara

// position de la camera
gui.add( controlValores, "PX", -5, 5 ).name( "P_X" ).onChange( mostrar_consola );
gui.add( controlValores, "PY", -5, 5 ).name( "P_Y" ).onChange( mostrar_consola );
gui.add( controlValores, "PZ", -5, 5 ).name( "P_Z" ).onChange( mostrar_consola );

// punto a quel esta mirando la camera
gui.add( controlValores, "aX", -5, 5 ).name( "aX" ).onChange( mostrar_consola );
gui.add( controlValores, "aY", -5, 5 ).name( "aY" ).onChange( mostrar_consola );
gui.add( controlValores, "aZ", -5, 5 ).name( "aZ" ).onChange( mostrar_consola );

// indica la verticalidad de la camera
gui.add( controlValores, "UpX", -1, 1 ).name( "UpX" ).onChange( mostrar_consola );
gui.add( controlValores, "UpY", -1, 1 ).name( "UpY" ).onChange( mostrar_consola );
gui.add( controlValores, "UpZ", -1, 1 ).name( "UpZ" ).onChange( mostrar_consola );
}

function cam(val)
{
if (val === 1) camera_v = camera;
    else camera_v = camNew; 
}

function recolocar_pir()
{
// TODO 2: posicionar el objeto pir_lines frente a la camara nueva
//         Hay que modificar las matrices de pir_lines no las coordenadas de los vértices
//         La pregunta a responder es: Donde pueden estar esas matrices?
//         Las matrices a modificar son: pir_lines.matrix y pir_lines.matrixWorld
/***********/


pir_lines.matrix.copy( camNew.matrixWorld );
pir_lines.matrixWorld.copy( camNew.matrixWorld );


/************/
}

function init() {
	var canvasWidth = window.innerWidth * 0.9;
	var canvasHeight = window.innerHeight * 0.9;

// TODO 2: hay que descomentar todo este bloque para que aparezcan los botones
/*************/
	container = document.createElement('div');
	document.body.appendChild(container);

	var info = document.createElement('div');
	info.style.position = 'absolute';
	info.style.top = '10px';
	info.style.width = '100%';
	info.style.textAlign = 'center';
	info.innerHTML += 'cambio de cámara:<input id="cam1" type="button" onclick="cam(1)" value="cam1"/><input id="cam_new" type="button" onclick="cam(2)" value="cam_new"/><input id="coloca_pir" type="button" onclick="recolocar_pir()" value="colocar pantalla"/>';
	container.appendChild(info);
/******************** hasta aqui ********/

	
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
	// ejes: las líneas que representan el sistema de Ref de la cámara
	var line_material = new THREE.LineBasicMaterial({color: 0x0000ff});

	XYZgeometry = new THREE.Geometry();
	XYZgeometry.vertices.push(
	new THREE.Vector3( 1, 0, 2 ), // posicion_camara+R
	new THREE.Vector3( 0, 0, 2 ), // posición_camara
	new THREE.Vector3( 0, 1, 2 ), // posicion_camara+U
	new THREE.Vector3( 0, 0, 2 ), // posición_camara
	new THREE.Vector3( 0, 0, 3 ), // posicion_camara+D
	new THREE.Vector3( 0, 0, 2 ), // posición_camara
	new THREE.Vector3( 1, 0, 1 ), // posicion_camara-D+R
	new THREE.Vector3( -1, 0, 1 ), // posicion_camara-D-R
	new THREE.Vector3( 0, 0, 2 ) // posición_camara
);
	ejes = new THREE.Line( XYZgeometry, line_material );

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

/*********************/
	var pirgeometry = new THREE.Geometry();
	pirgeometry.vertices.push(
	new THREE.Vector3( 0, 0, 0 ), // 
	new THREE.Vector3( 0.6, 0.5, -0.6 ), //   dcha, arriba, delante
	new THREE.Vector3( -0.6, 0.5, -0.6 ), //  izda arriba, delante
	new THREE.Vector3( -0.6, -0.5, -0.6 ), //  izda, abajo, delante
	new THREE.Vector3( 0.6, -0.5, -0.6 ), //  dcha, abajo, delante
	new THREE.Vector3( 0.6, 0.5, -0.6 ) //  dcha, arriba, delante
	);
	pir_lines = new THREE.Line( pirgeometry, M_line_material );
	
	pir_lines.matrixAutoUpdate=false;       // no queremos que se recalculen sus 
					//matrices en funcion de rotation, scale y position
	pir_lines.rotationAutoUpdate=false;	// modificaremos sus matrices a mano
/***********************/
	
	var material = new THREE.MeshPhongMaterial( { color: 0xFff000 } ); // Material esfera
	var miotrageometria= new THREE.SphereGeometry( 0.4, 64, 64 ); //BoxGeometry( 1, 1, 1 );
	var miotroobjeto = new THREE.Mesh (miotrageometria, material); 

	var yotroobjeto = new THREE.Mesh (miotrageometria, material); 
	// SCENE

	scene = new THREE.Scene();
	scene.add( light );
	scene.add( ambientLight );
	scene.add( ejes );
	scene.add( M_ejes );
	scene.add( pir_lines );

	scene.add( miotroobjeto );
	scene.add( yotroobjeto );
	yotroobjeto.position.z = -2;

        setupGUI();
	mostrar_consola();
	camera_v = camera;
	// TODO 3: descomentar esta sentencia
	camNew.matrixAutoUpdate=false;  // calcularemos las matrices nosotros

}

function animate() {
	window.requestAnimationFrame( animate );
	render();
}

function render() {
	var delta = clock.getDelta();
	cameraControls.update(delta);
	renderer.render( scene, camera_v );
}

try {
	init();
	animate();
} catch(e) {
	var errorReport = "Your program encountered an unrecoverable error, can not draw on canvas. Error was:<br/><br/>";
	$('#container').append(errorReport+e);
}
