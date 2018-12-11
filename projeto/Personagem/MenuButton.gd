extends Button

const Declaration = preload("res://Scripts/ScreensEnum.gd");

export (Declaration.Screen) var screen;
var parent;

func _ready():
	parent = global.canvas.get_node("MainMenuControl");
	self.connect("button_down",self,"on_click");
	pass

func on_click():
	parent.emit_signal("onButtonClick", screen);
	


