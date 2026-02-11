extends CharacterBody2D

const SPEED = 200.0
const JUMP_FORCE = -400.0
const GRAVITY = 900.0

func _physics_process(delta):
	# Gravedad
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Movimiento horizontal
	var direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.x = direction * SPEED

	# Salto
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_FORCE

	move_and_slide()
