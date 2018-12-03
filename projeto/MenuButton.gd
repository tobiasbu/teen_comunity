extends Button

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

const Declaration = preload("res://ScrensEnum.gd");

export (Declaration.Screen) var screen;
# onready var button = get_node(self);
onready var parent = get_tree().get_root().get_child(0).get_node("MainMenuControl");

func _ready():
	
	
	
	self.connect("button_down",self,"on_click");
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func on_click():
	print(parent.name);
	parent.setScreen(screen);

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
