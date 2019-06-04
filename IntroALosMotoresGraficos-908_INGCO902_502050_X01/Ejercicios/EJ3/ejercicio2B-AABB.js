// primer ejercicio con three.js
// crear una geometria teniendo en cuenta el orden de los vértices
var camera, scene, renderer;
var cameraControls;
var controlValores;
var clock = new THREE.Clock();
var ambientLight, light;
var miobjeto;
var miotroobjeto;
var eleccion=1;


function visibilidad (bbox, A, B, C, D) //mira si el AABB intersecta o no con el plano Ax+By+Cz=D y en función de la variable "elección" devuelve true o false 
{
// TODO programar de forma eficiente el cálculo de la interseccion entre un plano y una caja envolvente alineada con los ejes (AABB)
//   y en funcion del resultado y del valor de la variable eleccion devolver el valor de la visibilidad
	var n = new THREE.Vector3(A,B,C);
	var bmin = bbox.min;
	var bmax = bbox.max;
	
	var tmp1 = n.dot(bmin);
	var tmp2 = n.dot(bmax);
	
	if ( tmp1 > D && tmp2 >D  )
	{
		resultado = true;
	}
	else
	{
		resultado = false;
	}


return resultado;
}

function mira_corte()
{
var A=1.0;
var B=0.0;
var C=0.0;
var D=0.0;

A = controlValores.A;
B = controlValores.B;
C = controlValores.C;
D = controlValores.D;
 scene.traverse 
    (
    function (object)
      {
      if (object instanceof THREE.Mesh)
        {
	var bbox = new THREE.Box3().setFromObject(object);
	object.visible= visibilidad(bbox, A, B, C, D);
	//console.log("irteera:"+A+", "+ B +", "+C+", "+D+" emaitza:"+ object.visible);
        }
      }
    );
}

function elegir(val)
{
if (val === -1) eleccion = -1;
  else if (val === 0) eleccion = 0;
        else eleccion = 1;
mira_corte();
}

function setupGUI()
{

controlValores =
    {
    A: 0.5,
    B: 0.5,
    C: 0.5,
    D: 0.0
    };

var gui = new dat.GUI();

// cambios en el objeto

gui.add( controlValores, "A", -10, 10, 1 ).name( "A" ).onChange( mira_corte );
gui.add( controlValores, "B", -10, 10, 1 ).name( "B" ).onChange( mira_corte );
gui.add( controlValores, "C", -10, 10, 1 ).name( "C" ).onChange( mira_corte );
gui.add( controlValores, "D", -10, 10, 1 ).name( "D" ).onChange( mira_corte );
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
	info.innerHTML += 'Mostrar objetos: <input id="mostrar" type="button" onclick="elegir(-1)" value="lado oxcuro"/><input id="ocultar" type="button" onclick="elegir(0)" value="cortantes"/><input id="visible" type="button" onclick="elegir(1)" value="lado visible"/>';
	container.appendChild(info);

	// CAMERA

	camera = new THREE.PerspectiveCamera( 45, window.innerWidth / window.innerHeight, 1, 80000 );
	camera.position.set(-1,1,3);
	camera.lookAt(0,0,0);

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

	
	// SCENE

	scene = new THREE.Scene();
	scene.add( light );
	scene.add( ambientLight );

// Muchos objetos
	
	var migeometria= new THREE.BoxGeometry( 0.1, 0.1, 0.1 );//SphereGeometry( 0.7, 64, 64 ); //BoxGeometry( 1, 1, 1 );

        var material = new THREE.MeshPhongMaterial( { color: 0xFF0000 } ); // Material de color rojo
	for (i=0;i<10;i++)
	    {
	    for (j=0; j<10; j++)
		{
		for (k=0; k<10; k++)
		    {
		    miobjeto = new THREE.Mesh (migeometria, material); // Crea el objeto
		    miobjeto.position.x = i/5.0-1;miobjeto.position.y = j/5.0-1;miobjeto.position.z = k/5.0-1;
		    scene.add( miobjeto );
		    }
		}
	    }
        //miotroobjeto = new THREE.Mesh (migeometria, material); 
        setupGUI();
        mira_corte();
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
