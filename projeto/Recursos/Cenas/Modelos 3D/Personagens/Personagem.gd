extends Spatial

onready var skeleton = get_child(0)
onready var neck = skeleton.find_bone("neck.x")
onready var Arms = get_child(1)
onready var Legs = get_child(2)

onready var boneNeck = 21
onready var currentStatus = -1
onready var currentPosture = 0
onready var transicao = 0.2

func _ready():
	_setStatus(0)
#----------------------------------------------------------------
func _update(up, down, left, right, jump):
	if !up and !down and !left and !right and !jump:
		_setStatus(0)
	
	if up and !down and !left and !right and !jump:
		_setStatus(1)
#----------------------------------------------------------------
func _olhaPara(direcao):
	if Legs.get_animation(Legs.current_animation).track_is_enabled(boneNeck):
		Legs.get_animation(Legs.current_animation).track_set_enabled(boneNeck,false)
	skeleton.set_bone_pose(neck,direcao)
#----------------------------------------------------------------
func _setStatus(status):
#----------------------------------------------------------------
	if status == 0 and status != currentStatus:
		currentStatus = status
		
		if currentPosture == 0:
			Legs.play("Idle_Arm", transicao)
			Arms.play("Idle", transicao)
#----------------------------------------------------------------
	if status == 1 and status != currentStatus:
		currentStatus = status
		Legs.play("Jog_Fwd_Arm", transicao)
		Arms.play("Jog_Fwd", transicao)
#----------------------------------------------------------------
	if status == 2 and status != currentStatus:
		currentStatus = status
		Legs.play("Jog_Back_Arm", transicao)
		Arms.play("Jog_Back", transicao)
#----------------------------------------------------------------