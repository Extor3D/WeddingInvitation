extends KinematicBody2D

onready var rot_tween = $RotTween
onready var stween = $STween
onready var sprite = $AnimatedSprite
onready var animator = $AnimationPlayer
onready var heart = $Heart

onready var grab_sound = $GrabSound
onready var heart_sound = $HeartSound

export var speed = 30

export var jump_height = 64.0
export var jump_time_to_peak = 0.3
export var jump_time_to_descent = 0.35

export var can_gravity = true

var anim_change = 1

var movement_dir = 0
var inv_mov = 1
var velocity = Vector2()

var on_ground = false
var forced_jump = false

var DEFAULT_GRAVITY = Vector2(0,1).rotated(deg2rad(0))
var gravity_normal = DEFAULT_GRAVITY
var gravity_zchanged = false


enum STATES {Idle, Walk, Fall, Look, Grab}
var state = STATES.Idle
var last_state = state

var stop = false
var end = false
var is_looking = false
var is_grabbing = false

onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
onready var fall_gravity : float = ((-0.1 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

func change():
	anim_change += 1
	
func grab():
	is_grabbing = true
	grab_sound.play()
	animator.play("Damage")
	
func spawn_heart():
	heart.show()
	heart.get_child(0).play("HeartAnimation")
	heart_sound.play()

func _process(_delta):
	if !stop:
		get_input()
	if end:
		movement_dir = 1
		speed = 10
		
func look():
	is_looking = true
	
func end():
	stop = true
	end = true

func get_input(): 
	movement_dir = Input.get_vector("left","right","null","null").x
	
	if Input.is_action_just_pressed("left") || Input.is_action_just_pressed("right") :
		# -90 bis 90 normal
		if rotation_degrees > 92 || (rotation_degrees < -92 && rotation_degrees > -200):
			inv_mov = -1
		else:
			inv_mov = 1
	
	movement_dir *= inv_mov
	
func _physics_process(delta):
	last_state = state
	state = get_state()
	calculate_sprite()
	var snap = 8
	
	#Speed Smoothing
	var n_speed = speed * movement_dir
	
	if abs(n_speed) > abs(velocity.x):
		velocity.x = (5*velocity.x + n_speed)/6
	else:
		if abs(velocity.x) > 5:
			velocity.x = (3*velocity.x + n_speed)/4
		else:
			velocity.x = 0

	
	if is_on_floor():
		on_ground = true
	else:
		velocity.y += get_gravity() * delta
	
	var ca = [abs(jump_gravity), abs(fall_gravity)].max()
	velocity.y = clamp(velocity.y,jump_velocity*5,ca/3)
	
	#Move and Slide
	calculate_gravity_normal()
	var grav_rot = gravity_normal.angle_to(Vector2(0,1))
	
	velocity = move_and_slide_with_snap(velocity.rotated(-grav_rot),gravity_normal*snap,-gravity_normal,true,4,deg2rad(80)).rotated(grav_rot)

func calculate_gravity_normal():
	var n_g = DEFAULT_GRAVITY
	
	if n_g != gravity_normal:
		gravity_normal = (7*gravity_normal + n_g)/8
		gravity_normal = (7*gravity_normal + n_g)/8
		gravity_zchanged = true
		
func get_gravity():
	return fall_gravity
	
func stop_moving():
	movement_dir = 0
	stop = true

func calculate_sprite():
	sprite.playing = true
	sprite.speed_scale = 1
	
	var n_rot = rad2deg(gravity_normal.angle()) - 90
	rotation_degrees = n_rot
	
	if movement_dir < 0:
		sprite.flip_h = true
	elif movement_dir > 0:
		sprite.flip_h = false
	
	if state == STATES.Idle:
		sprite.animation = "idle" + str(anim_change)
	elif state == STATES.Walk:
		sprite.animation = "walk" + str(anim_change)
		if movement_dir == 0:
			sprite.speed_scale = clamp((abs(velocity.x) / speed)*4,0,1)
	elif state == STATES.Fall:
		if !is_on_ceiling():
			if last_state != STATES.Fall:
				stween.remove_all()
				stween.interpolate_property(sprite,"scale",null,Vector2(0.85,1.18),0.35,Tween.TRANS_SINE,Tween.EASE_OUT)
				stween.start()
			sprite.animation = "fall"
	
	if state != STATES.Fall && sprite.scale != Vector2(1,1):
		if last_state == STATES.Fall:
			stween.remove_all()
		
		if !stween.is_active():
			stween.remove_all()
			stween.interpolate_property(sprite,"scale",null,Vector2(1,1),0.2,Tween.TRANS_BACK,Tween.EASE_OUT)
			stween.start()
	
	if state == STATES.Look:
		sprite.animation = "look"
		
	if state == STATES.Grab:
		sprite.animation = "grab"

func get_state():
	var n_state = STATES.Idle
	
	if is_on_floor() && velocity.x != 0:
		n_state = STATES.Walk
	elif (!is_on_floor() && velocity.y > 0):
		n_state = STATES.Fall
		
	if is_looking:
		n_state = STATES.Look
		
	if is_grabbing:
		n_state = STATES.Grab
	
	return n_state
	
func is_player():
	return true
