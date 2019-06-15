////////////////////////////////////////////////////////////////////////////////
// Ejercicio 5.2. Luces rotando

var camera, scene, renderer,
    light1, light2, light3,
    loader, obj, sphere1, sphere2, sphere3;

function init() {

    var canvasWidth = window.innerWidth * 0.9;
    var canvasHeight = window.innerHeight * 0.9;
    var canvasRatio = canvasWidth / canvasHeight;

    camera = new THREE.PerspectiveCamera( 45, window.innerWidth / window.innerHeight, 0.1, 80000 );
    camera.position.set(0,0,8);
    camera.lookAt(0,0,0);

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

    // Scene and lights
    scene = new THREE.Scene();

    scene.add( new THREE.AmbientLight( 0x00020 ) );

    light1 = new THREE.PointLight( 0xff0040, 1, 50 );

    scene.add( light1 );

    light2 = new THREE.PointLight( 0x0040ff, 1, 50 );
    scene.add( light2 );

    light3 = new THREE.PointLight( 0x80ff80, 1, 50 );
    scene.add( light3 );

    var sphere_geom = new THREE.SphereGeometry(0.2, 8, 8);
    sphere1 = new THREE.Mesh( sphere_geom, new THREE.MeshBasicMaterial( { color: light1.color } ));
    sphere2 = new THREE.Mesh( sphere_geom, new THREE.MeshBasicMaterial( { color: light2.color } ));
    sphere3 = new THREE.Mesh( sphere_geom, new THREE.MeshBasicMaterial( { color: light3.color } ));

    // -1.83 3.0 0.53;
    sphere1.position.x = light1.position.x = -1.83;
    sphere1.position.y = light1.position.y = 3.0;
    sphere1.position.z = light1.position.z = 0.53;

    //1.83 1.07 -1.81
    sphere2.position.x = light2.position.x = 1.83;
    sphere2.position.y = light2.position.y = 1.07;
    sphere2.position.z = light2.position.z = -1.81;

    //1.98 -2.23 1.88
    sphere3.position.x = light3.position.x = 1.98;
    sphere3.position.y = light3.position.y = -2.23;
    sphere3.position.z = light3.position.z = 1.88;

    scene.add(sphere1);
    scene.add(sphere2);
    scene.add(sphere3);
    loader = new THREE.JSONLoader();
    loader.load( 'suzanne.json', function ( geometry ) {
        obj = new THREE.Mesh( geometry, new THREE.MeshPhongMaterial( { color: 0xffffff,
                                                                       overdraw: 0.5 } ) );
        scene.add( obj );
    } );
}

function animate() {

    requestAnimationFrame( animate );
    render();
}

function render() {

    var time = Date.now() * 0.0005;

    if ( obj ) obj.rotation.y -= 0.01;

    var l1x = Math.sin( time * 0.7 ) * 2;
    var l1y = Math.cos( time * 0.5 ) * 3;
    var l1z = Math.cos( time * 0.3 ) * 2;

    // TODO set sphere1 and light1 in position (l1x, l1y, l1z)


    var l2x = Math.cos( time * 0.3 ) * 2;
    var l2y = Math.sin( time * 0.5 ) * 3;
    var l2z = Math.sin( time * 0.7 ) * 2;

    // TODO set sphere2 and light2 in position (l2x, l2y, l2z)


    var l3x = Math.sin( time * 0.7 ) * 2;
    var l3y = Math.cos( time * 0.3 ) * 3;
    var l3z = Math.sin( time * 0.5 ) * 2;

    // TODO set sphere3 and light3 in position (l3x, l3y, l3z)

    renderer.render( scene, camera );
}

try {
    init();
    animate();
} catch(e){
    var errorReport="Your program encountered an unrecoverable error, can not draw on canvas. Error was:<br/><br/>";
    $('#container').append(errorReport+e);
}