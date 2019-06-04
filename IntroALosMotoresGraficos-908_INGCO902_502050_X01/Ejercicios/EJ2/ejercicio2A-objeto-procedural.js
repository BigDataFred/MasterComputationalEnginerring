// primer ejercicio con three.js
// crear una geometria teniendo en cuenta el orden de los vértices
var camera, scene, renderer;
var cameraControls;
var controlValores;
var clock = new THREE.Clock();
var ambientLight, light;
var miobjeto;
var preX=0;
var preY=0;
var preZ=0;

function rota_objeto()
{
var x=0;
var y=0;
var z=0;
var angulo = 0;
var i=0;
var a = new THREE.Vector3( 0, 0, 0 );
var b = new THREE.Vector3( 0, 0, 0 );
var n = new THREE.Vector3( 0, 0, 0 );
var ind1=0;
var ind2=0;
var mimatriz = new THREE.Matrix4();

if (controlValores.ejeX !== preX)
    {
    angulo = (controlValores.ejeX-preX)/10.0;
    preX = controlValores.ejeX;
    // TODO calcular matriz de rotación respecto a eje X
    mimatriz.set(1, 0, 0, 0,
			0, Math.cos(angulo), -Math.sin(angulo), 0,
			0, Math.sin(angulo), Math.cos(angulo), 0,
			0, 0, 0, 1);
    x= 1;
    }
   else if (controlValores.ejeY !== preY)
          {
	  angulo = (controlValores.ejeY-preY)/10.0;
          preY = controlValores.ejeY;
	  // TODO calcular matriz de rotación respecto a eje Y
	 mimatriz.set( Math.cos(angulo), 0, Math.sin(angulo), 0,
				0, 1, 0, 0,
				-Math.sin(angulo), 0, Math.cos(angulo), 0,
				0, 0, 0, 1);
          y= 1;
          }
        else 
          {
	  angulo = (controlValores.ejeZ-preZ)/10.0;
	  preZ = controlValores.ejeZ;
	  // TODO calcular matriz de rotación respecto a eje Z
          mimatriz.set( Math.cos(angulo), -Math.sin(angulo), 0, 0,
				Math.sin(angulo), Math.cos(angulo), 0, 0,
				0, 0, 1, 0,
				0, 0, 0, 1);
          z= 1;
	  };

var mivertice = new THREE.Vector3(0,0,0);

 // TODO calcular las coordenadas de cada vértice y modificarlas en la tabla de vertices del objeto
//     a tener en cuenta: en un motor gráfico no se recalculan las coordenadas de la geometria
//     solo se guardan las matrices tras multiplicar la antigua con la nueva transformación!

for (i=0;i<miobjeto.geometry.vertices.length; i++)
    {
	miobjeto.geometry.vertices[i].applyMatrix4 ( mimatriz );
    }


 // TODO recalcular las coordenadas de los vectores normales de los poligonos y reasignar
//     a tener en cuenta: en un motor gráfico no se recalculan las coordenadas de la geometria
//     solo se guardan las matrices tras multiplicar la antigua con la nueva transformación!

var faces    = miobjeto.geometry.faces;
var vertices = miobjeto.geometry.vertices;
for (i=0;i<miobjeto.geometry.faces.length; i++)
    {
    // calcular vector normal...
   
    var v = vertices[faces[i].a];	
    var p1 = new THREE.Vector3(v.x,v.y,v.z);

    var v = vertices[faces[i].b];	
    var p2 = new THREE.Vector3(v.x,v.y,v.z);

    var v = vertices[faces[i].c];	
    var p3 = new THREE.Vector3(v.x,v.y,v.z);
    
    var v = p2.sub(p1);
    var w = p3.sub(p1);
		
    var n2 = v.cross(w);

    miobjeto.geometry.faces[i].normal.set(n2.x,n2.y,n2.z);
    }


// TODO descomentar las dos siguientes sentencias para que three.js haga lo que deba hacer
miobjeto.geometry.verticesNeedUpdate=true;
miobjeto.geometry.normalsNeedUpdate=true;
}

function mueve_objeto(val)
{
var i;

// TODO mover los vértices hacia arriba tanto como dice val (puede ser negativo)
var tmp = new THREE.Vector3(0,val,0);

for (i=0;i<miobjeto.geometry.vertices.length; i++)
    {
     miobjeto.geometry.vertices[i].add(tmp);
    }

// TODO descomentar la siguiente sentencia
miobjeto.geometry.verticesNeedUpdate=true;
}

function setupGUI()
{

controlValores =
    {
    ejeX: 0.0,
    ejeY: 0.0,
    ejeZ: 0.0
    };

var gui = new dat.GUI();

// cambios en el objeto

gui.add( controlValores, "ejeX", 0, 100, 0 ).name( "ejeX" ).onChange( rota_objeto );
gui.add( controlValores, "ejeY", 0, 100, 0 ).name( "ejeY" ).onChange( rota_objeto );
gui.add( controlValores, "ejeZ", 0, 100, 0 ).name( "ejeZ" ).onChange( rota_objeto );
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
	info.innerHTML += 'Mover objeto:<input id="Arriba" type="button" onclick="mueve_objeto(0.1)" value="Up"/><input id="abajo" type="button" onclick="mueve_objeto(-0.1)" value="Down"/>';
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

	// OBJECT
	
    
        var migeometria = new THREE.Geometry();
        var miotrageometria = new THREE.Geometry();
	var num_lados = 16;
	var luz = 0.1;
	// en funcion del numero de lados he de saltar tantos radianes
	var salto = Math.PI * 2 /num_lados;	
	// TODO generar la tabla de vértices: el número depende de num_lados!
	for (i=0; i<num_lados; i++)
		{
		migeometria.vertices.push ( new THREE.Vector3(  0.1*Math.cos(i*salto), 0.9, 0.1*Math.sin(i*salto) ) ) ; // Top	
		migeometria.vertices.push ( new THREE.Vector3(  1*Math.cos(i*salto), -0.9, 1*Math.sin(i*salto) ) ) ; // Bottom
		}
	// TODO generar la tabla de polígonos y asignar a cada poígono el vector normal que le corresponde
	//  el numero de poligonos depende de num_lados
	var a = new THREE.Vector3( 3, 1, 2 );
	var b = new THREE.Vector3( 0, 2, 1 );
	var n = new THREE.Vector3( 0, 0, 0 );
	var indplustwo=2.0;
	var tmp = new THREE.Vector3( indplustwo, indplustwo, indplustwo );
	for (i=0; i<(num_lados); i++)
		{
		
		var p1 = new THREE.Vector3(migeometria.vertices[a.x].x, migeometria.vertices[a.x].y, migeometria.vertices[a.x].z );
		var p2 = new THREE.Vector3(migeometria.vertices[a.y].x, migeometria.vertices[a.y].y, migeometria.vertices[a.y].z );
		var p3 = new THREE.Vector3(migeometria.vertices[a.z].x, migeometria.vertices[a.z].y, migeometria.vertices[a.z].z );
		
		var v = p2.sub(p1);
		var w = p3.sub(p1);
		
		n = v.cross(w);	
		 //console.log(  n );
		
		migeometria.faces.push ( new THREE.Face3( a.x,a.y,a.z, n) ) ;
		
		var p1 = new THREE.Vector3(migeometria.vertices[b.x].x, migeometria.vertices[b.x].y, migeometria.vertices[b.x].z );
		var p2 = new THREE.Vector3(migeometria.vertices[b.y].x, migeometria.vertices[b.y].y, migeometria.vertices[b.y].z );
		var p3 = new THREE.Vector3(migeometria.vertices[b.z].x, migeometria.vertices[b.z].y, migeometria.vertices[b.z].z );
		
		var v = p2.sub(p1);
		var w = p3.sub(p1);
		
		n = v.cross(w);
		//console.log(  n );
		
		migeometria.faces.push ( new THREE.Face3( b.x,b.y,b.z, n) ) ;
			
		a.add(tmp);
		b.add(tmp);
			
		if (a.x>num_lados*2-1)
			{
			a.x=1;
			a.y = num_lados*2-1;
			a.z = 0;
			b.x = num_lados*2-2;
			b.y = 0;
			b.z = num_lados*2-1;
			}
			
		//console.log(a.x,a.y,a.z);
		//console.log(b.x,b.y,b.z);
			
		}
	
    var material = new THREE.MeshPhongMaterial( { color: 0xFF0000 } ); // Material de color rojo
    // TODO tras generar la geometria hay que generar la malla junto con el material
    // descomentar la sentencia:
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
