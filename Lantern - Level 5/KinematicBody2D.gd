extends KinematicBody2D

# Physics constants
const UP = Vector2(0, -1)
const GRAVITY = 20
const ACCELERATION = 25
const MAX_SPEED = 100
const JUMP_HEIGHT = -300

var motion = Vector2()
var is_jumping = false
var friction = false

func _physics_process(delta):
	motion.y += GRAVITY
	
	# Control horizontal movement
	if Input.is_action_pressed("ui_right"):
		motion.x = min(motion.x + ACCELERATION, MAX_SPEED)

		if is_jumping:
			motion.x = min(motion.x + 2 * ACCELERATION, 2 * MAX_SPEED)
	elif Input.is_action_pressed("ui_left"):
		motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)

		if is_jumping:
			motion.x = max(motion.x - 2 * ACCELERATION, 2 * -MAX_SPEED)
	else:
		friction = true
		motion.x = lerp(motion.x, 0, 0.2)

		
	# Control vertical movement
	if is_on_floor():
		is_jumping = false
		if Input.is_action_just_pressed("ui_up"):
			is_jumping = true
			motion.y = JUMP_HEIGHT
		if friction:
			motion.x = lerp(motion.x, 0, 0.2)

	
	
	motion = move_and_slide(motion, UP)
