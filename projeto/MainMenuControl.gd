extends MarginContainer

const Declaration = preload("res://ScrensEnum.gd");

var currentScreen = Declaration.Screen.None;
onready var firstNode = get_tree().get_root().get_child(0);


export (NodePath) var title_node_path;
onready var title_node = get_node(title_node_path);
export (NodePath) var credits_node_path;
onready var credits_node = get_node(credits_node_path);

onready var story_node = firstNode.get_node("Story");
onready var cameraControl = firstNode.get_node("CameraControl");

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	setScreen(Declaration.Screen.Title);
	
	# self.connect("menu_button_down", self, "setScreen");

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
				cameraControl._setCameraState(Declaration.CameraState.Story);
			
			Declaration.Screen.Exit:
				get_tree().quit();
	
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
