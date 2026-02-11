extends CharacterBody2D

# --- CONFIGURACIÓN ---
@export var speed := 60      # velocidad del enemigo
@export var gravity := 900   # gravedad

# --- VARIABLES INTERNAS ---
var direction := -1          # -1 izquierda, 1 derecha

# --- FÍSICA / MOVIMIENTO ---
func _physics_process(delta):
	# aplicar gravedad
	if not is_on_floor():
		velocity.y += gravity * delta

	# movimiento horizontal
	velocity.x = direction * speed

	# mover el enemigo
	move_and_slide()

	# cambiar de dirección si choca con pared
	if is_on_wall():
		direction *= -1
		$Sprite2D.flip_h = direction > 0
