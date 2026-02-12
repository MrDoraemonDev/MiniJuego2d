extends CharacterBody2D

# --- CONFIGURACIÓN ---
@export var speed := 60
@export var gravity := 900

var direction := -1  # -1 = izquierda, 1 = derecha

func _ready():
	print("Enemigo listo:", name)
	if not is_in_group("Enemies"):
		add_to_group("Enemies")  # asegurarse de que esté en el grupo
	print("¿Está en grupo Enemies?:", is_in_group("Enemies"))

func _physics_process(delta):
	# Gravedad
	if not is_on_floor():
		velocity.y += gravity * delta

	# Movimiento horizontal
	velocity.x = direction * speed

	move_and_slide()

	# Cambiar de dirección si choca con pared
	if is_on_wall():
		print("Enemigo chocó con pared, cambiando dirección")
		direction *= -1
		if $Sprite2D:
			$Sprite2D.flip_h = direction > 0
