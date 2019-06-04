// Ejercicio 4: obtener la matriz de rotación respecto a un eje cualquiera que pasa por un punto dado.
//   utilizando la matriz recalcular las coordenadas de los vértices y de las normales de los polígonos.

var camera, scene, renderer;
var cameraControls;
var controlValores;
var clock = new THREE.Clock();
var ambientLight, light;
var miobjeto;

function mens_log()
{
var x=0;
var y=0;
var z=0;
var px=0.0;
var py=0.0;
var pz=0.0;
var a = 0;
var i=0;
var n = new THREE.Vector4( 0, 0, 0, 0 );
var mimatriz = new THREE.Matrix4();
var miMT1 = new THREE.Matrix4();
var mivertice = new THREE.Vector3(0,0,0);

a = controlValores.alpha;
x=controlValores.ejeX;
y=controlValores.ejeY;
z=controlValores.ejeZ;
px=controlValores.PX;
py=controlValores.PY;
pz=controlValores.PZ;

console.log("valores = "+x+", " + y+", " +z+", " +px+", " +py +", " +pz+", "+a);
}

function rotar_obj(val)
{
var x=0;
var y=0;
var z=0;
var px=0.0;
var py=0.0;
var pz=0.0;
var a = 0;
var i=0;


var mimatriz = new THREE.Matrix4();

a = controlValores.alpha;  //ángulo de rotación. Puede ser 0
a = a*val;
	// vector que me da la dirección del eje. Puede ser un vector no unitario
x=controlValores.ejeX;
y=controlValores.ejeY;
z=controlValores.ejeZ;
	// Punto por el que pasa el vector.
px=controlValores.PX;
py=controlValores.PY;
pz=controlValores.PZ;

    // TODO calcular matriz de rotación respecto al eje (x,y,z) que pasa por punto (px,py,pz) y que rota a radianes
	var T1 = new THREE.Matrix4( );
	T1.makeTranslation(-px,-py,-pz);// translate (px,py,pz) to (0,0,0)
	
	var xyz = new THREE.Vector3( x, y, z );
	xyz.divideScalar( xyz.length() );
	console.log(xyz);
	console.log(px,py,pz);

	var M = new THREE.Matrix4( );
	M.makeRotationAxis( xyz, a );
		
	var T2 = new THREE.Matrix4( );
	T2.makeTranslation(px,py,pz);// translate (0,0,0) back to (px,py,pz)
	
	mimatriz.multiplyMatrices(T2,M);//postmultiply
	mimatriz.multiply(T1);//postmultiply
	
 // TODO calcular las coordenadas de cada vértice y modificarlas en la tabla de vertices del objeto
//     a tener en cuenta: en un motor gráfico no se recalculan las coordenadas de la geometria
//     solo se guardan las matrices tras multiplicar la antigua con la nueva transformación!
	for (i=0;i<miobjeto.geometry.vertices.length; i++)
	    {
		miobjeto.geometry.vertices[i].applyMatrix4 ( mimatriz );
	    }

 // TODO recalcular las coordenadas de los vectores normales de los poligonos y reasignar.
//     A tener en cuenta: en un motor gráfico no se recalculan las coordenadas de la geometria.
//     solo se guardan las matrices tras multiplicar la antigua con la nueva transformación!
   
   var n = new THREE.Vector4( 0, 0, 0,0 );
   for (i=0;i<miobjeto.geometry.faces.length; i++)
      {
      n.set(miobjeto.geometry.faces[i].normal.x, miobjeto.geometry.faces[i].normal.y, miobjeto.geometry.faces[i].normal.z ,0);
      n.applyMatrix4(mimatriz);
      miobjeto.geometry.faces[i].normal.set(n.x, n.y, n.z);
      for (j =0; j<miobjeto.geometry.faces[i].vertexNormals.length; j++)
	{
	n.set(miobjeto.geometry.faces[i].vertexNormals[j].x, miobjeto.geometry.faces[i].vertexNormals[j].y, miobjeto.geometry.faces[i].vertexNormals[j].z ,0);
        n.applyMatrix4(mimatriz);
	miobjeto.geometry.faces[i].vertexNormals[j].set(n.x, n.y, n.z);
	}
      }
    

// TODO si se han modificado los vertices y las nomales descomentar:
    miobjeto.geometry.verticesNeedUpdate=true;
    miobjeto.geometry.normalsNeedUpdate=true;
 
}


function setupGUI()
{

controlValores =
    {
    ejeX: 0.0,
    ejeY: 0.0,
    ejeZ: 0.0,
    PX: 0.0,
    PY: 0.0,
    PZ: 0.0,
    alpha: 0.0
    };

var gui = new dat.GUI();

// cambios en el objeto

gui.add( controlValores, "ejeX", -1, 1 ).name( "ejeX" ).onChange( mens_log );
gui.add( controlValores, "ejeY", -1, 1 ).name( "ejeY" ).onChange( mens_log );
gui.add( controlValores, "ejeZ", -1, 1 ).name( "ejeZ" ).onChange( mens_log );
gui.add( controlValores, "PX", -5, 5 ).name( "PX" ).onChange( mens_log );
gui.add( controlValores, "PY", -5, 5 ).name( "PY" ).onChange( mens_log );
gui.add( controlValores, "PZ", -5, 5 ).name( "PZ" ).onChange( mens_log );
gui.add( controlValores, "alpha", 0, 3.15 ).name( "alpha" ).onChange( mens_log );
}

function init() {
	var canvasWidth = window.innerWidth * 0.9;
	var canvasHeight = window.innerHeight * 0.9;
	// botones  para interacción up y down
	container = document.createElement('div');
	document.body.appendChild(container);

	var info = document.createElement('div');
	info.style.position = 'absolute';
	info.style.top = '10px';
	info.style.width = '100%';
	info.style.textAlign = 'center';
	info.innerHTML += 'Rotar respecto a cualquier eje: <input id="right" type="button" onclick="rotar_obj(-1)" value="right"/><input id="left" type="button" onclick="rotar_obj(1)" value="left"/>';
	container.appendChild(info);

	// CAMERA

	camera = new THREE.PerspectiveCamera( 45, window.innerWidth / window.innerHeight, 1, 80000 );
	camera.position.set(-1,1,3);
	camera.lookAt(0,0,0);

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
	
    
 //       var migeometria = new THREE.Geometry();
	var migeometria = new THREE.CylinderGeometry( 0.1, 1, 1.8, 16 );
        var miotrageometria = new THREE.Geometry();

    var material = new THREE.MeshPhongMaterial( { color: 0xFF0000 } ); // Material de color rojo
    miobjeto = new THREE.Mesh (migeometria, material); // Crea el objeto

    miotrageometria= new THREE.SphereGeometry( 0.7, 64, 64 ); //BoxGeometry( 1, 1, 1 );
    var miotroobjeto = new THREE.Mesh (miotrageometria, material); 
	
	// SCENE

	scene = new THREE.Scene();
	scene.add( light );
	scene.add( ambientLight );

	scene.add( miobjeto );
	scene.add( miotroobjeto );
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
