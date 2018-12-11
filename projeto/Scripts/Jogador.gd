
extends KinematicBody

const Declaration = preload("res://Personagem/CharacterDeclaration.gd");



#onready var GRAVIDADE = -9.8
onready var speed = 10
onready var sideSpeed = 5
onready var personagem = get_child(2)
onready var orb = get_child(1)
onready var origin = orb.get_child(0);

var onground = false;
var sensibilidade = 0.005;
var analog_velocity = Vector3();
var mobile = true;
export var active = false;

func _ready():
	# Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	set_physics_process(true)
	set_process_input(true)
	if (mobile):
		speed *= 0.4

#func _gravidade(delta):
#	if GRAVIDADE > -9.8:
#		GRAVIDADE -= 17.8 * delta
#	else:
#		GRAVIDADE = -9.8
#
#	move_and_slide(Vector3(0, GRAVIDADE * 50 * delta, 0), Vector3(0, -1, 0), 25.0)

func setCamera(camera):
	#origin.add_child(camera);
	orb.camera = camera;
	
func setActive(flag):
	active = flag;
	orb.active = flag;
	origin.get_child(0).visible = true;
	origin.get_child(0).current = true;
	
	# Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func getAnimState(up, left, right, down):
	
	if !up and !down and (left or right):
		return Declaration.AnimState.Side;
	
	if up or down or left or right:
		return Declaration.AnimState.Walk;
	
	return Declaration.AnimState.Idle;
		

func _move(delta):
	
	var up;
	var down;
	var right;
	var left;
	var shift;
	

	if (!mobile):
		
		up =  Input.is_action_pressed("ui_up")
		shift = Input.is_action_pressed("ui_shift")
		down = Input.is_action_pressed("ui_down")
		right = Input.is_action_pressed("ui_right")
		left = Input.is_action_pressed("ui_left")
		
		var hdir =  int(right) - int(left);
		
		if hdir != 0:
			hdir *= sideSpeed;
			move_and_collide(transform.basis.x * hdir * delta)
			
		if up:
			if shift:
				move_and_collide(transform.basis.z * speed * -1.30 * delta)
			else:
				move_and_collide(transform.basis.z * speed *-1 * delta)
		if down:
			move_and_collide(transform.basis.z * speed * delta)
	else:
	
		var spd_norm = analog_velocity * speed * delta * -1;
		
		
		
		
		#rotation.x = clamp(rotation.x - event.relative.y * sensibilidade, deg2rad(-45), deg2rad(45))
		
		
		move_and_collide(spd_norm);
		
		
		
		#var rad = atan2(analog_velocity.y, analog_velocity.x);
		#spd.z = -spd_norm.x * velocidade * delta;
		#spd.x = spd_norm.y * velocidade * delta;
		
		if (analog_velocity.length() > 0):
			#var rad = atan2(analog_velocity.x, analog_velocity.z);
			#rotation.y = rad;
			up = true;
			left = true;
			right = true;
			down = false;
			
	
	
	#if (spd.x != 0 || spd.z != 0):
	#var rad = atan2(analog_velocity.y, analog_velocity.x)
	#move_and_collide(transform.basis.z * rad * velocidade * 1 * delta);
	
	
	
	
	# if right:
		
	# if left:
	# 	move_and_collide(transform.basis.x * hdir * -1 * delta)
	#if space:
	#	GRAVIDADE = 10
	
	# personagem._olhaPara(orb.get_transform().inverse())
	personagem._update(getAnimState(up, left, right, down))

func _physics_process(delta):
	if (active):
		_move(delta)

func _input(event):
	
	if (active):
		#if event is InputEventMouseMotion:
			#rotation.y -= event.relative.x * sensibilidade
		pass
			
func analog_force_change(inForce, inStick):
	if (inForce.length() < 0.1):
		analog_velocity = Vector3(0,0,0)
		return;
	else:
		analog_velocity = Vector3(inForce.y, 0,inForce.x)


func _on_Analog_force_change( inForce, inStick ):
	analog_force_change(inForce, inStick)
