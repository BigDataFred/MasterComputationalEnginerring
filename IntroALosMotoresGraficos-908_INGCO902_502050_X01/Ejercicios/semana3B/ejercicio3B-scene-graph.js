// ejercicio 5 con three.js
// crear una geometria teniendo en cuenta el orden de los vértices
var camera, scene, renderer;
var cameraControls;
var clock = new THREE.Clock();
var ambientLight, light;
// TODO declarar los nodos a los que aplicar las rotaciones
/*
var nodo_cabeza;
var nodo_parte_superior;
var nodo_cuello_para_arriba;
*/

function negar_obj()
{
var val = controlValores.cuello;
// TODO asignar la rotacion adecuada al nodo adecuado, y... control de limites?
// nodo_adecuado.rotation.x = val;

}
function inclina_obj(val)
{
var val = controlValores.cintura;
// TODO asignar la rotacion adecuada al nodo adecuado, y... control de limites?
// nodo_adecuado.rotation.x = val;
}
function mirar_lado(val)
{
var val = controlValores.cabeza;
// TODO asignar la rotacion adecuada al nodo adecuado, y... control de limites?
// nodo_adecuado.rotation.x = val;
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
	//	la base va hasta una altura de 0.75 (desde -0.75 hasta0.75) es 1.5 veces más grande que la esfera definida en "migeometria"
	//	el tronco hay que situralo justo tocando la base. Teniendo en cuenta su longitud, va desde 0.75 hasta 1.75. Inclinarse debe rotar desde esa altura 
	//	el cuello hay que situarlo tocando el torso: debe ir de 1.75 a 2.25. La negación debe rotar desde su punto mas bajo.
	//	la cabeza tendrá que situarse tocando el cuello
	//	la nariz hay que situarla tocando la cabeza hacia fuera. La cabeza tiene un radio de 0.5 por lo que habrá que desplazar la nariz.
	
	// TODO  eliminar esto que es incorrecto
	scene.add(bola1); 
	bola1.position.x = 2;
	// TODO  eliminar esto que es incorrecto
	scene.add(bola3); 
	bola3.position.x = -2;
	// TODO  eliminar esto que es incorrecto
	scene.add(torso); 
	torso.position.y=2;
	// TODO  eliminar esto que es incorrecto
	scene.add(cuello); 
	cuello.position.y = -2;
	// TODO  eliminar esto que es incorrecto
	scene.add(nariz); 
	// TODO añadir a la escena el monigote
	// scene.add( monigote );

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
