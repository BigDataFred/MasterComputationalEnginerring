////////////////////////////////////////////////////////////////////////////////
//
// Combine two textures using shaders

var camera, scene, renderer;
var cameraControls;
var clock = new THREE.Clock();
var Offset = 0.0;

var obj; // object

function init() {
    var canvasWidth = window.innerWidth * 0.9;
    var canvasHeight = window.innerHeight * 0.9;
    var canvasRatio = canvasWidth / canvasHeight;

    camera = new THREE.PerspectiveCamera( 45, window.innerWidth / window.innerHeight, 1, 80000 );
    camera.position.set(0,0,5);
    camera.lookAt(0,0,0);

    renderer = new THREE.WebGLRenderer( { antialias: true } );
    renderer.setSize( canvasWidth, canvasHeight );
    renderer.setClearColor( 0xAAAAAA, 1.0 );

    renderer.gammaInput = true;
    renderer.gammaOutput = true;

    var container = document.getElementById('container');
    container.appendChild( renderer.domElement );

    cameraControls = new THREE.OrbitControls( camera, renderer.domElement );
    cameraControls.target.set(0, 0, 0);

}

function createShaderMaterial() {

    // TODO
    //
    // baseTexture is texture with image "images/planets/earth_atmos_2048.jpg"
    var baseTexture = THREE.ImageUtils.loadTexture("images/planets/earth_atmos_2048.jpg");
	baseTexture.wrapS = THREE.RepeatWrapping;
        baseTexture.wrapT = THREE.RepeatWrapping;
    // TODO
    //
    // cloudTexture is texture with image "images/planets/earth_clouds_2048.png"
    var cloudTexture = THREE.ImageUtils.loadTexture("images/planets/earth_clouds_2048.png");
	cloudTexture.wrapS = THREE.RepeatWrapping;
	cloudTexture.wrapT = THREE.RepeatWrapping;
        cloudTexture.repeat = new THREE.Vector2(1.0,1.0);

    // TODO
    //
    // add the following uniform variables:
    //
    // uBaseTexture: the base texture (type 't'):
    //        Assign texture baseTexture
    //
    // uCloudTexture: the cloud texture (type 't'):
    //        Assign texture cloudTexture
    //
    // uCloudOffset: the offset of U component of tex. coordinates
    //        Assign an initial value of 0.

    var material = new THREE.ShaderMaterial( {
				
		uniforms: {
			uBaseTexture:  { type:"t", value: baseTexture  },
			uCloudTexture: { type:"t", value: cloudTexture  },
			uCloudOffset:  { type:"f", value: 0 }
		},
		
        vertexShader: document.getElementById( 'vertexShader' ).textContent,
        fragmentShader: document.getElementById( 'fragmentShader' ).textContent
    });
    return material;
}

function fillScene() {
    scene = new THREE.Scene();
    ambientLight = new THREE.AmbientLight( 0xFFFFFF );

    light = new THREE.DirectionalLight( 0xFFFFFF, 0.7 );
    light.position.set( 0, 0.5, -0.3 );

    scene.add( ambientLight );
    scene.add( light );

    var material = createShaderMaterial();
    obj = new THREE.Mesh(new THREE.SphereGeometry(1,32,32),
                             material);
    scene.add(obj);
}


function animate() {
    window.requestAnimationFrame( animate );
    render();
}

function render() {
    var delta = clock.getDelta();
    cameraControls.update(delta);

    // TODO
    //
    // modify uCloudOffset value
    Offset = Offset+1.0/(360.0);
  
    //console.log(Offset);
    obj.material.uniforms.uCloudOffset.value = Offset;
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
