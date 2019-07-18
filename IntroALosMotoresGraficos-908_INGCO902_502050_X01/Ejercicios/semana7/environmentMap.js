////////////////////////////////////////////////////////////////////////////////
// Chapel textures

var camera, scene, renderer;
var cameraControls;
var clock = new THREE.Clock();

var obj;

function init() {
    var canvasWidth = window.innerWidth * 0.9;
    var canvasHeight = window.innerHeight * 0.9;
    var canvasRatio = canvasWidth / canvasHeight;

    camera = new THREE.PerspectiveCamera( 45, window.innerWidth / window.innerHeight, 1, 80000 );
    camera.position.set(0, 0, 5);
    camera.lookAt(0,0,0);

    // RENDERER
    renderer = new THREE.WebGLRenderer( { antialias: true } );
    renderer.setSize( canvasWidth, canvasHeight );
    renderer.setClearColor( 0xAAAAAA, 1.0 );

    renderer.gammaInput = true;
    renderer.gammaOutput = true;

    // add to DOM
    // Add to DOM
    var container = document.getElementById('container');
    container.appendChild( renderer.domElement );

    // CONTROLS
    cameraControls = new THREE.OrbitControls( camera, renderer.domElement );
    cameraControls.target.set(0, 0, 0);

}

function fillScene() {
    scene = new THREE.Scene();
    //scene.fog = new THREE.Fog( 0x808080, 2000, 4000 );

    // LIGHTS

    ambientLight = new THREE.AmbientLight( 0x202020 );

    light = new THREE.DirectionalLight( 0xFFFFFF, 0.7 );
    light.position.set( 0, 0.5, 0.5 );

    scene.add( ambientLight );
    scene.add( light );

    var cubemap = createSkyTexture();

    // following code from https://github.com/mrdoob/three.js/blob/master/examples/webgl_materials_cubemap.html

    var skyShader = THREE.ShaderLib[ "cube" ];
    skyShader.uniforms[ "tCube" ].texture = cubemap;

    var skyMaterial = new THREE.ShaderMaterial( {
        fragmentShader: skyShader.fragmentShader,
        vertexShader: skyShader.vertexShader,
        uniforms: skyShader.uniforms,
        depthWrite: false,
        side: THREE.BackSide
    });

    var skybox = new THREE.Mesh( new THREE.BoxGeometry( 100, 100, 100 ), skyMaterial );
    scene.add(skybox);


    var reflectionMaterial = new THREE.MeshPhongMaterial({
        color: 0xcccccc,
        envMap: cubemap
    });

    loader = new THREE.JSONLoader;
    loader.load('suzanne.json', function(geom) {
        obj = new THREE.Mesh(
            geom,
            reflectionMaterial);
        obj.rotation.y += 180 * Math.PI/180;
        scene.add(obj);
    });
}

function createSkyTexture() {

    var skyBoxFnames = [
        'images/sky_xpos.png',
        'images/sky_xneg.png',
        'images/sky_ypos.png',
        'images/sky_yneg.png',
        'images/sky_zpos.png',
        'images/sky_zneg.png'
    ];
    var cubemap = THREE.ImageUtils.loadTextureCube(skyBoxFnames);
    cubemap.format = THREE.RGBFormat;
    return cubemap;
}


function animate() {
    window.requestAnimationFrame( animate );
    render();
}

function render() {
    var delta = clock.getDelta();
    cameraControls.update(delta);
    //if ( obj ) obj.rotation.y -= 0.01;
    renderer.render( scene, camera );

}

try {
    init();
    fillScene();
    animate();
} catch(e) {
    var errorReport = "Your program encountered an unrecoverable error, can not draw on canvas. Error was:<br/><br/>";
    $('#container').append(errorReport+e);
}