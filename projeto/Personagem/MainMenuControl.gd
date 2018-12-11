extends MarginContainer

const Declaration = preload("res://Scripts/ScreensEnum.gd");


var currentScreen = Declaration.Screen.None;
# onready var firstNode = get_tree().get_root().get_child(0);


export (NodePath) var title_node_path;
onready var title_node = get_node(title_node_path);
export (NodePath) var credits_node_path;
onready var credits_node = get_node(credits_node_path);

onready var global = get_node("/root/global");
var story_node;
var cameraControl;

signal onButtonClick;

func _ready():
	story_node = global.firstNode.get_node("CanvasLayer/Story");
	cameraControl = global.firstNode.get_node("CameraControl");
	setScreen(Declaration.Screen.Title);
	pass

func setScreen(screen):
	if (currentScreen != screen):
		currentScreen = screen;
		match currentScreen:
			Declaration.Screen.Title:
				title_node.show();
				credits_node.hide();
				story_node.hide();
			
			Declaration.Screen.Credits:
				title_node.hide();
				credits_node.show();
			
			Declaration.Screen.Story:
				title_node.hide();
				story_node.show();
				cameraControl.setCameraState(Declaration.CameraState.Story);
			
			Declaration.Screen.Exit:
				get_tree().quit();
	
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_MainMenuControl_onButtonClick(screen):
	setScreen(screen);
