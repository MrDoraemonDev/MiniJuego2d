extends CharacterBody2D

# --- CONFIGURACIÓN ---
@export var speed := 60       # Velocidad de patrulla
@export var gravity := 900    # Gravedad para caer al suelo

var direction := -1           # -1 = izquierda, 1 = derecha

func _ready():
	print("Enemigo listo:", name)

	# Asegurarse de que esté en el grupo "Enemies"
	if not is_in_group("Enemies"):
		add_to_group("Enemies")
	print("¿Está en grupo Enemies?:", is_in_group("Enemies"))

func _physics_process(delta):
	# --- Aplicar gravedad ---
	if not is_on_floor():
		velocity.y += gravity * delta

	# --- Movimiento horizontal ---
	velocity.x = direction * speed

	# Mover al enemigo
	move_and_slide()

	# --- Cambiar dirección al chocar con pared ---
	if is_on_wall():
		print("Enemigo chocó con pared, cambiando dirección")
		direction *= -1
		if $Sprite2D:
			$Sprite2D.flip_h = direction > 0
