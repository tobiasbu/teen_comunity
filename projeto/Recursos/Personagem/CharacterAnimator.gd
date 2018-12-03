


extends Spatial;

const Declaration = preload("res://Recursos/Personagem/CharacterDeclaration.gd");

onready var skeleton = get_child(0)
onready var currentStatus = Declaration.AnimState.None
onready var animationPlayer = get_child(1)
onready var transtionStep = 0.15


# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	_setStatus(Declaration.AnimState.Idle);
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _update(status):
	_setStatus(status)

func _setStatus(status):
	if status != currentStatus:
		currentStatus = status
		match status:
			 Declaration.AnimState.Idle: animationPlayer.play('Idle', transtionStep)
		
			 Declaration.AnimState.Walk: animationPlayer.play('Walking', transtionStep)
		
			 Declaration.AnimState.Side: animationPlayer.play('WalkSide', transtionStep)

