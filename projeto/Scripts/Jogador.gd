
extends KinematicBody

const Declaration = preload("res://Personagem/CharacterDeclaration.gd");


onready var speed = 10
onready var sideSpeed = 5
onready var personagem = get_child(2)
onready var orb = get_child(1)
onready var origin = orb.get_child(0);

var onground = false;
var sensibilidade = 0.005;
var analog_velocity = Vector3();
var MOBILE = OS.get_name() == "Android";
export var active = false;

func _ready():
	set_physics_process(true)
	set_process_input(true)
	if (MOBILE):
		speed *= 0.4

func setCamera(camera):
	orb.camera = camera;
	
func setActive(flag):
	active = flag;
	orb.active = flag;
	origin.get_child(0).visible = true;
	origin.get_child(0).current = true;

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
	

	if (!MOBILE):	
		up =  Input.is_action_pressed("ui_up")
		shift = Input.is_action_pressed("ui_shift") # TODO: correr segurando shift
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
		# TODO: rotação da visão da câmera baseado no analógico direito
		var spd_norm = analog_velocity * speed * delta * -1;
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
