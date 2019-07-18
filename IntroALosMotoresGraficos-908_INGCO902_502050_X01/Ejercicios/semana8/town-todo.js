////////////////////////////////////////////////////////////////////////////////
// Town
////////////////////////////////////////////////////////////////////////////////

var camera, scene, renderer;
var clock = new THREE.Clock();
var barrios = new Array();

var controlValores;

var R = new THREE.Vector3(1,0,0);     // Ejes del sistema de referencia de la cámara
var D = new THREE.Vector3(0,0,1);     // Right y Deep

var E = new THREE.Vector3(0,0.5,2);   // Posición de la cámara
var at = new THREE.Vector3(0,0.5,0);  // Punto al que mira

var rangulo=0.07;
var speed=0;


function izda_dcha() {

	var angulo;
	if (controlValores.Yaw > 0) 
		angulo = -rangulo;
	else angulo = rangulo;

	////////////////////////////////////////////////////////////////////////////////////////////////////////	
	//
	// TODO Calcular matriz de rotación para hacer rotar el punto de atención alrededor de la posición de la cámara. 
	//		El punto de ateción debe permanecer a la misma altura, es decir, la rotación no debe modificar la altura 
	//		a la que se encuentra el punto de atención, por tanto, la rotación debe ser respecto al eje Y (eje vertical) 
	//		del sistema de referencia del mundo.
	//
	////////////////////////////////////////////////////////////////////////////////////////////////////////

	// Código...
	var x = at.x;
	var y = at.y;
	var z = at.z;
	
	var T1 = new THREE.Matrix4( );
	T1.makeTranslation(-x,-y,-z);// translate (px,py,pz) to (0,0,0)

	var T2 = new THREE.Matrix4( );
	T2.makeTranslation(x,y,z);// translate (0,0,0) back to (px,py,pz)

	var xyz = new THREE.Vector3( 0, 1, 0 );
	xyz.divideScalar( xyz.length() );

	var M = new THREE.Matrix4( );
	M.makeRotationAxis( xyz, angulo );
	
    var auxmat = new THREE.Matrix4();
	auxmat.multiplyMatrices(T2,M);//postmultiply
	auxmat.multiply(T1);//postmultiply
	
	////////////////////////////////////////////////////////////////////////////
	//
	// TODO Aplicar la matriz al punto de atención, al vector D y al vector R.
	//
	////////////////////////////////////////////////////////////////////////////

	// Código...
	E.applyMatrix4( auxmat );
	R.applyMatrix4( auxmat );
	D.applyMatrix4( auxmat );
	
	renovar_camara();
}


function arriba_abajo() {
var angulo;
var newat = new THREE.Vector3(at.x,at.y,at.z);  // punto al que mira
if (controlValores.Pitch > 0) angulo = rangulo;
	else angulo = -rangulo;

	////////////////////////////////////////////////////////////////////////////
	//
	// TODO Calcular la matriz de rotación para hacer rotar el punto de atención 
	//		alrededor de la posición de la cámara. 
	//		El efecto debe ser que la cámara mire hacia arriba o hacia abajo, 
	//		por lo que la rotación debe ser respecto al eje R del sistema de 
	//		referencia de la cámara (eje X de la sistema de referencia de la cámara).
	//
	////////////////////////////////////////////////////////////////////////////

	// Código...
	var x = at.x;
	var y = at.y;
	var z = at.z;
	var T1 = new THREE.Matrix4( );
	T1.makeTranslation(-x,-y,-z);// translate (px,py,pz) to (0,0,0)

	var T2 = new THREE.Matrix4( );
	T2.makeTranslation(x,y,z);// translate (0,0,0) back to (px,py,pz)

	var xyz = new THREE.Vector3( R.x, R.y, R.z );
	xyz.divideScalar( xyz.length() );

	var M = new THREE.Matrix4( );
	M.makeRotationAxis( xyz, angulo );
    
	var auxmat = new THREE.Matrix4();
	auxmat.multiplyMatrices(T2,M);//postmultiply
	auxmat.multiply(T1);//postmultiply
	
	////////////////////////////////////////////////////////////////////////////
	//
	// TODO Obtener el candidato para el punto de atención.
	//
	////////////////////////////////////////////////////////////////////////////

	// Código...
	E.applyMatrix4( auxmat );
	D.applyMatrix4( auxmat );
	
	////////////////////////////////////////////////////////////////////////////
	//
	// TODO Controlar que, al aplicar la rotación, el candidato a punto de atención 
	//		no haga que la cámara pase a mirar hacia el lado opuesto al que miraba. 
	//		Es decir, la cámara debe quedar mirando hacia el mismo lado al que miraba. 
	//		Para ello, el candidato a punto de atención no debe cruzar el plano definido 
	//		por el eje X de la cámara y el eje Y del mundo y que pasa por el punto donde 
	//		está la cámara.
	//
	////////////////////////////////////////////////////////////////////////////

	// Movimiento_permitido = true o false en función de que cruce o no cruce el plano
	var movimiento_permitido;

	// Código...

	////////////////////////////////////////////////////////////////////////////
	//
	// TODO Asignar true o false al movimiento permitido
	//
	////////////////////////////////////////////////////////////////////////////

	// Código...

	if (movimiento_permitido) {
		// NO he pasado el plano vertical!!

		////////////////////////////////////////////////////////////////////////////
		//    
	    // TODO Hacer que el punto de atención sea el candidato
		//
		////////////////////////////////////////////////////////////////////////////

		// Código...

	}
	// else no cambio nada 

	renovar_camara();
}


////////////////////////////////////////////////////////////////////////////
//
// TODO Función que determina si un punto dado entra en algún 
//		Bounding Box (BBox)de los objetos de tipo Mesh de la escena
//
////////////////////////////////////////////////////////////////////////////

function avance_permitido(p) {
	var posibilidad = true;
	
	scene.traverse (
		function (object) {
			if (object instanceof THREE.Mesh) {
				if (object.name !="ground") { 
					// no quiero problemas con el BBox del suelo
			    	var bbox = new THREE.Box3().setFromObject(object);

					////////////////////////////////////////////////////////////////////////////
					//
			    	// TODO Mirar si el punto P es interno al BBox del objeto y 
			    	// actuar en consecuencia
					//
					////////////////////////////////////////////////////////////////////////////

					// Código...
			    }	
		  	}
		}
	);
	return posibilidad;
}

////////////////////////////////////////////////////////////////////////////
//
// TODO Calcular los nuevos puntos que determinan la posición de la cámara 
//		y el punto de atención al avanzar la cámara.
//
////////////////////////////////////////////////////////////////////////////

function advance() {
	var newE = new THREE.Vector3(E.x,E.y,E.z);  // candidato a nueva posición de la cámara

	////////////////////////////////////////////////////////////////////////////
	//
	// TODO Calcular el punto candidato a posición de la cámara.
	//
	////////////////////////////////////////////////////////////////////////////

	// Código...
	var direction = new THREE.Vector3(at.x,at.y,at.z);
	newE.add( camNew.getWorldDirection( direction ) );
	
	E.x = newE.x;
	E.y = newE.y;
	E.z = newE.z;
	
	if (avance_permitido(newE)) {
		////////////////////////////////////////////////////////////////////////////
		//
	    // TODO Si el nuevo punto es un punto permitido, modificar los valores de 
	    // 		la cámara que haya que modificar.
		//
		////////////////////////////////////////////////////////////////////////////

    	// Código ...
		
		
    	renovar_camara();
    }
}


function set_speed() {
	speed = controlValores.Speed;
	speed = speed/10.0;
	advance();
}

function init() {
    var canvasWidth = window.innerWidth * 0.9;
    var canvasHeight = window.innerHeight * 0.9;
    var canvasRatio = canvasWidth / canvasHeight;

	camNew = new THREE.PerspectiveCamera( 45, window.innerWidth / window.innerHeight, 0.1, 10000 );
	camNew.position.set(E.x,E.y,E.z);
	camNew.lookAt(at.x,at.y,at.z);

    // RENDERER
    renderer = new THREE.WebGLRenderer( { antialias: true } );
    renderer.setSize( canvasWidth, canvasHeight );
    renderer.setClearColor( 0xAAAAAA, 1.0 );

    renderer.gammaInput = true;
    renderer.gammaOutput = true;

    // Add to DOM
    var container = document.getElementById('container');
    container.appendChild( renderer.domElement );
}

function createSquareGeometry(side, u, v) {
    var squareGeometry = new THREE.Geometry();
    squareGeometry.dynamic = true;
    var hside = Math.floor(side/2.0);

    // Generate vertices
    squareGeometry.vertices.push( new THREE.Vector3( -hside, -hside, 0.0 ));
    squareGeometry.vertices.push( new THREE.Vector3(  hside, -hside, 0.0 ));
    squareGeometry.vertices.push( new THREE.Vector3(  hside,  hside, 0.0 ));
    squareGeometry.vertices.push( new THREE.Vector3( -hside,  hside, 0.0 ));

    var uvs = [];
    uvs.push( new THREE.Vector2( 0.0, 0.0 ) );
    uvs.push( new THREE.Vector2( u, 0.0 ) );
    uvs.push( new THREE.Vector2( u, v ) );
    uvs.push( new THREE.Vector2( 0.0, v ) );

    // Generate faces
    squareGeometry.faces.push( new THREE.Face3( 0, 1, 2 ) );
    squareGeometry.faceVertexUvs[ 0 ].push( [ uvs[0], uvs[1], uvs[2] ] );
    squareGeometry.faces.push( new THREE.Face3( 0, 2, 3 ) );
    squareGeometry.faceVertexUvs[ 0 ].push( [ uvs[0], uvs[2], uvs[3] ] );
    return squareGeometry;
}

function createGround() {
    var geometry = createSquareGeometry( 16000, 10000, 10000 );
    var grass = THREE.ImageUtils.loadTexture("obj/grass512x512.jpg");
    grass.wrapT = THREE.RepeatWrapping;
    grass.wrapS = THREE.RepeatWrapping;
    var material = new THREE.MeshPhongMaterial({ map : grass });
    var ground = new THREE.Mesh( geometry, material);
    ground.rotation.x -= 90 * Math.PI / 180;
    ground.receiveShadow = true;
    ground.name= "ground"
    return ground;
}

function loadObject(jsonFile, imgFile, callback) {
    var loader = new THREE.JSONLoader();
    var texture = THREE.ImageUtils.loadTexture( imgFile );
    texture.generateMipmaps = true;
    texture.magFilter = THREE.LinearFilter;
    texture.minFilter = THREE.LinearMipMapLinearFilter;
    var material = new THREE.MeshPhongMaterial({ map: texture });
    loader.load(jsonFile, function( geom ) {
        callback(geom, material);
    });
}

function fillScene() {
    scene = new THREE.Scene();

    ambientLight = new THREE.AmbientLight( 0xFFFFFF );

    light = new THREE.DirectionalLight( 0xFFFFFF, 0.7 );
    light.position.set( 0, 0.5, -0.3 );

    light.castShadow = true;

    light.shadowMapWidth = 1024;
    light.shadowMapHeight = 2048;

    var d = 390;

    light.shadowCameraLeft = -d;
    light.shadowCameraRight = d;
    light.shadowCameraTop = d * 1.5;
    light.shadowCameraBottom = -d;

    light.shadowCameraFar = 3500;

    scene.add( ambientLight );
    scene.add( light );

    var ground = createGround();
    scene.add(ground);

	////////////////////////////////////////////////////////////////////////////
	//
	// TODO A vuestra elección, el número de barrios. 
	//		Como ejemplo pongo dos barrios, cada uno de ellos posicionados en 
	//		distintos puntos y con una orientación distinta
	//
	////////////////////////////////////////////////////////////////////////////

    var barrio1=new THREE.Object3D(); 
    var barrio2=new THREE.Object3D();
	var barrio3=new THREE.Object3D();
	var barrio4=new THREE.Object3D();
	
    barrios.push( barrio1 );
    barrios.push( barrio2 );
    barrios.push( barrio3 );
	barrios.push( barrio4 );
	
	var rdeg = [0,0,0,0];
	var coord = [
		[-7,-5],
		[-7,6],
		[14,-5],
		[14,6]
	];
	////////////////////////////////////////////////////////////////////////////
	//
	// TODO Añadir mas barrios y/o modificar las posiciones, orientaciones... 
	//
	////////////////////////////////////////////////////////////////////////////
	translateBarrio(barrios,coord);
	
    for (i=0;i<barrios.length; i++) scene.add(barrios[i]); // todos los barrios se visualizan

    loadObject("obj/casa/casa.json", "obj/casa/casa-512.jpg", insertCasaScene);
    loadObject("obj/casa2/casa2.json", "obj/casa2/casa2.jpg", insertCasa2Scene);
    loadObject("obj/chapel/chapel.json", "obj/chapel/chapel-256.jpg", insertChapelScene);
    loadObject("obj/wachhaus/wachhaus.json", "obj/wachhaus/wachhaus.jpg", insertWachhausScene);
	
	rotateBarrio(barrios,rdeg);
	
 }
 
var espacioCasa = 4;
function insertCasaScene(geom, material) {
    var i,j;
    
	////////////////////////////////////////////////////////////////////////////
	//
    // TODO Decidir el número de objetos de tipo "casa" en cada barrio
	//
	////////////////////////////////////////////////////////////////////////////

    var num_casa_en_cada_barrio = 18;

 	////////////////////////////////////////////////////////////////////////////
	//
    // TODO Es posible introducir casas en la escena, sin que pertenezcan a barrios.
	//
	////////////////////////////////////////////////////////////////////////////

   	/*var obj = new THREE.Mesh(geom, material);
    obj.position.x = -2;
    obj.position.z=-3;
    scene.add(obj);*/

    ////////////////////////////////////////////////////////////////////////////
	//
    // Código... En caso de que quieras tener casas en la escena 
    //		sin que pertenezcan a ningún barrio
	//
	////////////////////////////////////////////////////////////////////////////

    for (i=0;i<barrios.length; i++) {		
		
		console.log(barrios[i].position);
		var cnt = 0;
		var flag = 0;
		for (j=0;j<num_casa_en_cada_barrio; j++) {
	    	var obj = new THREE.Mesh(geom, material);

			////////////////////////////////////////////////////////////////////////////
			//
	    	// TODO Posicionar la casa en el barrio
			//
			////////////////////////////////////////////////////////////////////////////

	    	// Código...
			if (j<num_casa_en_cada_barrio/3){
			    obj.position.x = barrios[i].position.x-espacioCasa/2-(cnt*3);
			    obj.position.z=  barrios[i].position.z;				
			}
			else if (j >= num_casa_en_cada_barrio/3 & j < num_casa_en_cada_barrio/3*2 ){
				if (flag==0){cnt=0;flag = 1;};
			    obj.position.x = barrios[i].position.x-espacioCasa/2-(cnt*3);
			    obj.position.z=  barrios[i].position.z-espacioCasa;						
			}
			else {
				if (flag==1){cnt=0;flag = 2;};
			    obj.position.x = barrios[i].position.x-espacioCasa/2-(cnt*3);
			    obj.position.z=  barrios[i].position.z-espacioCasa*2;
			}
			cnt+=1;
	    	barrios[i].add(obj);
	    } 
	}
}

function insertCasa2Scene(geom, material) {
    var i,j;

    ////////////////////////////////////////////////////////////////////////////
	//
    // TODO Decidir el número de objetos de tipo "casa2" en cada barrio
	//
	////////////////////////////////////////////////////////////////////////////

    var num_casa2_en_cada_barrio = 10;

	////////////////////////////////////////////////////////////////////////////
	//
    // TODO Es posible introducir casas en la escena sin que pertenezcan a barrios.
	//
	////////////////////////////////////////////////////////////////////////////

	/*var obj = new THREE.Mesh(geom, material);
    obj.position.x = 2;
    obj.position.z=-3;
    scene.add(obj);*/

	////////////////////////////////////////////////////////////////////////////
	//
    // Código... En caso de que quieras tener casas en la escena sin que 
    //		pertenezcan a ningún barrio
	//
	////////////////////////////////////////////////////////////////////////////

    for (i=0;i<barrios.length; i++) {
		console.log(barrios[i].position);
		var cnt = 0;
		var flag = 0;
		for (j=0;j<num_casa2_en_cada_barrio; j++) {
	    	var obj = new THREE.Mesh(geom, material);

			////////////////////////////////////////////////////////////////////////////
			//
 	    	// TODO Posicionar la casa en el barrio
			//
			////////////////////////////////////////////////////////////////////////////

	    	// Código...
			if (j < num_casa2_en_cada_barrio/5){
			    obj.position.x = barrios[i].position.x+espacioCasa/2+(cnt*3);
				obj.position.z=  barrios[i].position.z;												
			}
			else if (j >= num_casa2_en_cada_barrio/5 & j < num_casa2_en_cada_barrio/5*2){
				if (flag == 0){cnt=0;flag=1;};
			    obj.position.x = barrios[i].position.x+espacioCasa/2+(cnt*3);
				obj.position.z=  barrios[i].position.z-espacioCasa/2;			
			}
			else if (j >= num_casa2_en_cada_barrio/5*2 & j < num_casa2_en_cada_barrio/5*3){
				if (flag == 1){cnt=0;flag=2;};
			    obj.position.x = barrios[i].position.x+espacioCasa/2+(cnt*3);
				obj.position.z=  barrios[i].position.z-espacioCasa/2*2;			
			}
			else if (j >= num_casa2_en_cada_barrio/5*3 & j < num_casa2_en_cada_barrio/5*4){
				if (flag ==2){cnt=0;flag=3;};
			    obj.position.x = barrios[i].position.x+espacioCasa/2+(cnt*3);
				obj.position.z=  barrios[i].position.z-espacioCasa/2*3;			
			}
			else {
				if (flag ==3){cnt=0;flag=4;};
			    obj.position.x = barrios[i].position.x+espacioCasa/2+(cnt*3);
				obj.position.z=  barrios[i].position.z-espacioCasa/2*4;			
			}
		    cnt+=1;
			
	    	barrios[i].add(obj);
	    }
	}
}

function insertChapelScene(geom, material) {
    var i,j; 

	////////////////////////////////////////////////////////////////////////////
	//
    // TODO decidir el número de objetos de tipo "chapel" en cada barrio
	//
	////////////////////////////////////////////////////////////////////////////
    var num_chapel_en_cada_barrio = 1;

	////////////////////////////////////////////////////////////////////////////
	//
    // TODO Introducir objetos de tipo "chapel" en la escena sin que pertenezcan 
    //		a barrios.
	//
	////////////////////////////////////////////////////////////////////////////

   	/*var obj = new THREE.Mesh(geom, material);
    obj.position.x = -2;
    obj.position.z=-5;
    scene.add(obj);*/

	////////////////////////////////////////////////////////////////////////////
	//
    // Código... En caso de que quieras tener objetos de tipo "chapel" en la escena
    //		sin que pertenezcan a ningún barrio
	//
	////////////////////////////////////////////////////////////////////////////

    for (i=0;i<barrios.length; i++) {
		for (j=0;j<num_chapel_en_cada_barrio; j++) {
	    	var obj = new THREE.Mesh(geom, material);

			////////////////////////////////////////////////////////////////////////////
			//
		    // TODO Posicionar el objeto de tipo "chapel" en el barrio
			//
			////////////////////////////////////////////////////////////////////////////

	    	// Código...
		    obj.position.x = barrios[i].position.x+espacioCasa;
			obj.position.z=  barrios[i].position.z-espacioCasa*3;	
			
	    	barrios[i].add(obj);
	    }
	}
}

function insertWachhausScene(geom, material) {
    var i,j; 

	////////////////////////////////////////////////////////////////////////////
	//
    // TODO Decidir el número de objetos de tipo "wachhaus" en cada barrio
	//
	////////////////////////////////////////////////////////////////////////////

    var num_wachhaus_en_cada_barrio = 1;

	////////////////////////////////////////////////////////////////////////////
	//
    // TODO Introducir objetos de tipo "wachhaus" en la escena, sin que pertenezcan 
    //		a barrios.
	//
	////////////////////////////////////////////////////////////////////////////

    var obj = new THREE.Mesh(geom, material);
    obj.position.x = -35;
    obj.position.z=-15;
   	scene.add(obj);
    
	var obj = new THREE.Mesh(geom, material);
    obj.position.x = -35;
    obj.position.z=15;
   	scene.add(obj);
	
    var obj = new THREE.Mesh(geom, material);
    obj.position.x = 38;
    obj.position.z=-15;
   	scene.add(obj);
	
    var obj = new THREE.Mesh(geom, material);
    obj.position.x = 38;
    obj.position.z=15;
   	scene.add(obj);
	
    var obj = new THREE.Mesh(geom, material);
    obj.position.x = 0;
    obj.position.z=15;
   	scene.add(obj);
	
    var obj = new THREE.Mesh(geom, material);
    obj.position.x = 0;
    obj.position.z=-20;
   	scene.add(obj);
	
	////////////////////////////////////////////////////////////////////////////
	//
    // Código... En caso de que quieras tener objeto de tipo "wachhaus" en la escena 
    //		sin que pertenezcan a ningún barrio
	//
	////////////////////////////////////////////////////////////////////////////

    for (i=0;i<barrios.length; i++) {
		for (j=0;j<num_wachhaus_en_cada_barrio; j++) {
	    	var obj = new THREE.Mesh(geom, material);

			////////////////////////////////////////////////////////////////////////////
			//
		    // TODO Posicionar el objeto de tipo "wachhaus" en el barrio
			//
			////////////////////////////////////////////////////////////////////////////

	    	// Código...
		    obj.position.x = barrios[i].position.x-espacioCasa*2;
			obj.position.z=  barrios[i].position.z+espacioCasa;
			
	    	barrios[i].add(obj);
	    }
	}
}


function rotateBarrio(barrios,rdeg){
    for (i=0;i<barrios.length; i++) {
		console.log(rdeg[i]);
		barrios[i].rotation.y = rdeg[i]*Math.PI/180;
	}	
}
function translateBarrio(barrios,coord){
    for (i=0;i<barrios.length; i++) {
		console.log(coord[i][0],coord[i][1]);
		barrios[i].position.x = coord[i][0];
		barrios[i].position.z = coord[i][1];
	}	
	
}

function renovar_camara() {
	camNew.position.copy(E);
	camNew.lookAt(at);
}

function animate() {
    window.requestAnimationFrame( animate );
    render();
}

function render() {
    var delta = clock.getDelta();
    advance();
    renderer.render( scene, camNew );
}

function setupGUI() {
	controlValores = {
	    Pitch: 0.0,
	    Yaw: 0.0,
	    Speed: 0.0
	};

	var gui = new dat.GUI();

	// Parámetros para obtener los ejes del sistema de referencia de la cámara

	gui.add( controlValores, "Yaw", -5, 5 ).name( "izda/dcha" ).onChange( izda_dcha );
	gui.add( controlValores, "Pitch", -5, 5 ).name( "arriba/abajo" ).onChange( arriba_abajo );
	gui.add( controlValores, "Speed", -5, 5 ).name( "Speed" ).onChange( set_speed );
}

try {
    init();
    fillScene();
    setupGUI();
    animate();
} catch(e) {
    var errorReport = "Your program encountered an unrecoverable error, can not draw on canvas. Error was:<br/><br/>";
    $('#container').append(errorReport+e);
}
