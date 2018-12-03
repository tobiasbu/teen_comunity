extends Spatial

const Declaration = preload("res://ScrensEnum.gd");

const cam_speed = 0.25;
var cameraState = Declaration.CameraState.Gimball;

onready var firstNode = get_tree().get_root().get_child(0);
onready var gimballPosition = get_child(0);
onready var storyPosition = get_child(1);

func _ready():
	pass

func _process(delta):
	if (cameraState == Declaration.CameraState.Gimball):
		rotate_y(cam_speed * delta);
	
	
func _setCameraState(state):
	
	if (state == cameraState):
		return;
		
	var camera;  
		
	if (cameraState == Declaration.CameraState.Gimball):
		camera = gimballPosition.get_child(0);
		gimballPosition.remove_child(camera);
		
		
	
	
	match state:
		Declaration.CameraState.Story: storyPosition.add_child(camera);
		
	camera.translation.x = 0;
	camera.translation.y = 0;
	camera.translation.z = 0;
	camera.transform.basis = Basis();
	transform.basis = Basis();
		
	cameraState = state;
		