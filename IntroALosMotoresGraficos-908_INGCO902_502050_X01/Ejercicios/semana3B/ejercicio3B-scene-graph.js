// ejercicio 5 con three.js
// crear una geometria teniendo en cuenta el orden de los vértices
var camera, scene, renderer;
var cameraControls;
var clock = new THREE.Clock();
var ambientLight, light;

// TODO declarar los nodos a los que aplicar las rotaciones
var nodo_cabeza = new THREE.Object3D();
var nodo_cuello_para_arriba = new THREE.Object3D();
var nodo_parte_superior = new THREE.Object3D();

function negar_obj()
{
var val = controlValores.cuello;
// TODO asignar la rotacion adecuada al nodo adecuado, y... control de limites?
if (val <= 0.1 & val >= -0.1){
	nodo_cuello_para_arriba.rotation.x = val;
};


}
function inclina_obj(val)
{
var val = controlValores.cintura;
// TODO asignar la rotacion adecuada al nodo adecuado, y... control de limites?
nodo_parte_superior.rotation.z = val;
}
function mirar_lado(val)
{
var val = controlValores.cabeza;
// TODO asignar la rotacion adecuada al nodo adecuado, y... control de limites?
nodo_cabeza.rotation.y = val;
}

function setupGUI()
{

controlValores =
    {
    cuello: 0.0,
    cabeza: 0.0,
    cintura: 0.0
    };

var gui = new dat.GUI();

// cambios en el objeto

gui.add( controlValores, "cuello", -0.5, 0.5 ).name( "cuello" ).onChange( negar_obj );
gui.add( controlValores, "cabeza", -1.6,1.6 ).name( "cabeza" ).onChange( mirar_lado );
gui.add( controlValores, "cintura", -0.6, 0 ).name( "cintura" ).onChange( inclina_obj );
}

function init() {
	var canvasWidth = window.innerWidth * 0.9;
	var canvasHeight = window.innerHeight * 0.9;

	// CAMERA

	camera = new THREE.PerspectiveCamera( 45, window.innerWidth / window.innerHeight, 1, 80000 );
	camera.position.set(10,2,2);
	camera.lookAt(0,2,0);

	// LIGHTS

	light = new THREE.DirectionalLight( 0xFFFFFF, 0.7 );
	light.position.set( 1, 1, 1 );
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

	// OBJECTS
	
    
    var migeometria = new THREE.SphereGeometry( 0.5, 64, 64 );//Geometry();
	var torsogeometria = new THREE.CylinderGeometry( 0.6, 0.1, 1, 32 );
	var narizgeometria = new THREE.CylinderGeometry( 0.2, 0.05, 0.5, 32 );
	var cuellogeometria = new THREE.BoxGeometry( 0.1, 0.5, 0.1 );//CylinderGeometry( 0.1, 0.1, 0.5, 32 );
	//narizgeometria.applyMatrix( new THREE.Matrix4().makeTranslation( 0, 0.5/2, 0) ); 
	
    var material = new THREE.MeshPhongMaterial( { color: 0xFF0000 } ); // Material de color rojo
    var bola1 = new THREE.Mesh (migeometria, material); // Crea la base 
    var torso = new THREE.Mesh (torsogeometria, material); // Crea el cono que representa el torso
    var bola3 = new THREE.Mesh (migeometria, material); // Crea la cabeza
    var cuello = new THREE.Mesh (cuellogeometria, material); // Crea el cuello
    var nariz = new THREE.Mesh (narizgeometria, material); // Crea la nariz
	
	// SCENE

	scene = new THREE.Scene();
	scene.add( light );
	scene.add( ambientLight );
	
	var monigote = new THREE.Object3D();
	//TODO generar el grafo de escena y asignar los objetos tipo Mesh a los nodos en el grafo de escena 
	//     con las posiciones y orientaciones adecuadas de forma que permita al monigote:
	//  1.- inclinarse y levantarse (rotación respecto al eje z: desde cintura para arriba sin modificar la base)
	//  2.- negar con el cuello y la cabeza (rotación respecto a eje x: de cuello para arriba sin modificar ni base ni torso)
	//  3.- mirar izquierda/derecha (rotación respecto al eje y: solo rota la cabeza (esfera +nariz), el cuello se queda en su sitio
	
	// posicionamiento de los objetos: 
	
	//	la base va hasta una altura de 0.75 (desde -0.75 hasta 0.75) es 1.5 veces más grande que la esfera definida en "migeometria"
	//scene.add(bola1); 
	bola1.position.x = 0;
	bola1.position.y = 0;
	bola1.scale.x = 1.5;
	bola1.scale.y = 1.5;
	bola1.scale.z = 1.5;
	
	//	el tronco hay que situralo justo tocando la base. Teniendo en cuenta su longitud, va desde 0.75 hasta 1.75. Inclinarse debe rotar desde esa altura 
	//scene.add(torso); 
	torso.position.x = 0;
	torso.position.y=1.25;
	
	//	el cuello hay que situarlo tocando el torso: debe ir de 1.75 a 2.25. La negación debe rotar desde su punto mas bajo.
	//scene.add(cuello); 
	cuello.position.y = 2;
	cuello.position.x = 0;
	
	//	la cabeza tendrá que situarse tocando el cuello
	//scene.add(bola3); 
	bola3.position.x = 0;
	bola3.position.y = 2.75;
	
	//	la nariz hay que situarla tocando la cabeza hacia fuera. La cabeza tiene un radio de 0.5 por lo que habrá que desplazar la nariz.
	//scene.add(nariz); 
	nariz.position.x = 0.5;
	nariz.position.y = 2.75;
	nariz.rotation.z = 0.5*Math.PI;
	
	// añadir a la escena el monigote	
	nodo_cabeza.add(bola3);
	nodo_cabeza.add(nariz);
	
	nodo_cuello_para_arriba.add(nodo_cabeza);
	nodo_cuello_para_arriba.add(cuello);
	
	nodo_parte_superior.add(torso);
	nodo_parte_superior.add(nodo_cuello_para_arriba);
	
	monigote.add(nodo_parte_superior);
	monigote.add(bola1);
	
	scene.add( monigote );
	

        setupGUI();
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
	animate();
} catch(e) {
	var errorReport = "Your program encountered an unrecoverable error, can not draw on canvas. Error was:<br/><br/>";
	$('#container').append(errorReport+e);
}
