extends CharacterBody2D

# --- MOVIMIENTO ---
const SPEED = 200.0
const JUMP_FORCE = -400.0
const GRAVITY = 900.0

# --- VIDA ---
@export var max_health: int = 3
@export var damage_cooldown: float = 2.0

var health: int
var can_take_damage: bool = true

func _ready():
	health = max_health
	print("Jugador listo. Vida:", health)

func _physics_process(delta):
	# Gravedad
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Movimiento horizontal
	var dir = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.x = dir * SPEED

	# Salto
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_FORCE

	move_and_slide()

# --- DAÑO ---
func take_damage(amount: int):
	print("Intentando recibir daño...")

	if not can_take_damage:
		print("No puede recibir daño (cooldown activo)")
		return

	health -= amount
	print("¡Daño recibido! Vida restante:", health)

	# Efecto visual: se pone rojo
	modulate = Color(1, 0.4, 0.4)
	
	if health <= 0:
		die()
	else:
		start_damage_cooldown()

func start_damage_cooldown():
	can_take_damage = false
	
	# Espera el tiempo del cooldown
	await get_tree().create_timer(damage_cooldown).timeout
	
	# Volver al color normal
	modulate = Color(1, 1, 1)
	can_take_damage = true
	print("Cooldown terminado, puede recibir daño otra vez")

func die():
	print("Jugador murió")
	queue_free()

# --- DETECCIÓN DE ENEMIGO ---
func _on_hitbox_body_entered(body):
	# Ignorar al propio Player
	if body == self:
		return

	print("Detectado contacto con:", body.name)
	print("¿Está en grupo Enemies?:", body.is_in_group("Enemies"))

	if body.is_in_group("Enemies"):
		print("Es enemigo directo!")
		take_damage(1)
	else:
		print("No es enemigo")
