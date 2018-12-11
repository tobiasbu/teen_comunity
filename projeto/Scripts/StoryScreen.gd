extends MarginContainer


const Declaration = preload("res://Scripts/ScreensEnum.gd");



export (NodePath) var photos_node_path;
onready var photos_node = get_node(photos_node_path);

export (NodePath) var text_node_path;
onready var text_node = get_node(text_node_path);

export (NodePath) var next_button_path;
onready var button_node = get_node(next_button_path);


onready var imagesPath = "res://Imagens/";

var photo0;
var photo1;
var photo2;
var photo3;

onready var cameraControl = global.firstNode.get_node("CameraControl");

var currentStory = -1;


func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	photo0 = load(imagesPath + "story1.png");
	photo1 = load(imagesPath + "story2.png");
	photo2 = load(imagesPath + "story3.png");
	photo3 = load(imagesPath + "story4.png");
	button_node.connect("button_down",self,"nextStoryStep");
	
	setStoryStep(0)
	
	pass
	
func nextStoryStep():
	var i = currentStory + 1;
	setStoryStep(i);
	
func setStoryStep(storyIndex):
	
	if (storyIndex == currentStory):
		return;
	
	match storyIndex:
		0:
			text_node.text = "Toda história começa em algum lugar.\nE nossa se inicia no bairro Vila Brás em São Leopoldo.";
			photos_node.texture = photo0;
		1:
			text_node.text = "Mas nem todo inicio é fácil. Os moradores desse lugar tiveram muitos problemas, uma vida dificil para estabelecer uma residencia.";
			photos_node.texture = photo1;
		2:
			text_node.text = "Embora isso, houve muita luta!\nA vizinhaça batalhou muito por seus direitos e por uma vida digna.";
			photos_node.texture = photo2;
			
		3: 
			text_node.text = "Uma das conquistas da comunidade foi a construção de uma escola João Goulart, realizada pelos próprios moradores. Hoje ela abriga mais de 1000 crianças e adolecentes do bairro!";
			photos_node.texture = photo3;
		4:
			text_node.text = "Devido à falta de cuidado e investimento, a escola foi se deteriorando com o passar do tempo.\nMas esse é só o começo..."
			
	if (storyIndex >= 5):
		hide();
		cameraControl.setCameraState(Declaration.CameraState.Start);
		
	# text_node.set_anchors_and_margins_preset(Control.PRESET_CENTER);
	currentStory = storyIndex;

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
