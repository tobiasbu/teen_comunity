extends Spatial

onready var orb_origin = get_child(0)
onready var orb_position = get_child(1)
onready var camera = orb_origin.get_child(0)

var sensibilidade = 0.005;
export var active = false;

func _ready():
	set_process_input(true)
	set_process(true)
	
func _input(event):
	if (active):
		#if event is InputEventMouseMotion:
			#rotation.x = clamp(rotation.x - event.relative.y * sensibilidade, deg2rad(-45), deg2rad(45))
		pass
		
func _process(delta):
	if (active):
		if orb_position.is_colliding() and !orb_position.get_collider().is_in_group("jogador"):
			camera.global_transform.origin = orb_position.get_collision_point()
		else:
			camera.global_transform.origin = orb_origin.global_transform.origin
