extends Spatial

const Declaration = preload("res://Scripts/ScreensEnum.gd");

const cam_speed = 0.25;


onready var gimballPosition = get_child(0);
onready var storyPosition = get_child(1);
onready var endStoryPosition = get_child(2);
var mainCamera;
var player;
var analog;
# onready var playerCamera = player.get_child(1).get_child(1)

var t = 0.0;
var trigger = 0;
var originTransform;
onready var cameraState = Declaration.CameraState.None;

func _ready():
	mainCamera = gimballPosition.get_node("MainCamera");
	player = global.firstNode.get_node("Jogador");
	analog = global.firstNode.get_node("ANALAOGUI/ANALOG_LEFT");
	analog.hide();
	setCameraState(Declaration.CameraState.Gimball);
	pass

func _process(delta):
	if (cameraState == Declaration.CameraState.Gimball):
		rotate_y(cam_speed * delta);
	elif (cameraState == Declaration.CameraState.Start):
		if (trigger == 0):
			t += (delta / 3.0);
			if (t >= 1.0):
				t = 1.0;
				trigger += 1;
			# var vec = mainCamera.translation.linear_interpolate(endStoryPosition.translation, t);
			# mainCamera.translation = vec;
			var trans = originTransform.interpolate_with(endStoryPosition.transform, t);
			mainCamera.transform = trans;
		elif(trigger == 1):
			t -= (delta / 2.0);
			if (t <= 0.0):
				trigger += 1;
		elif(trigger == 2):
			setCameraState(Declaration.CameraState.Game)
	
	
func setCameraState(state):
	
	if (state == self.cameraState):
		return;
		
	
	if (self.cameraState == Declaration.CameraState.Gimball):
		var cam = gimballPosition.get_child(0);
		gimballPosition.remove_child(cam);
		global.firstNode.add_child(cam);
	#	mainCamera = cam;
	#	print("hi")
		
	match state:
		Declaration.CameraState.Story: 
			mainCamera.translation = storyPosition.translation; # add_child(camera);
			mainCamera.transform.basis = storyPosition.transform.basis;
			
		Declaration.CameraState.Start:
			t = 0.0;
			originTransform = mainCamera.transform;
			
		Declaration.CameraState.Game:
			var cam = player.origin.get_child(0);
			mainCamera.current = false;
			mainCamera.set_identity();
			analog.show();
			#mainCamera.transform.basis = cam.transform.basis;
			#player.setCamera(mainCamera);
			player.setActive(true);
			
		Declaration.CameraState.Gimball:
			global.set_parent(gimballPosition, mainCamera)
			print("gimbs " + str(gimballPosition.get_child_count()))
		
	cameraState = state;
		