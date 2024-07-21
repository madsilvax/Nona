extends CharacterBody3D

@onready var jogador : CharacterBody3D = get_tree().get_first_node_in_group("Jogador")
@onready var sprite = $AnimatedSprite3D
@onready var raycast_3d = $RayCast3D

@export var move_speed = 2.0

var distraido = false

func _physics_process(delta):
	if distraido:
		return
	if jogador == null:
		return
	
	var direcao = jogador.global_position - global_position
	direcao.y = 0.0
	direcao = direcao.normalized()
	
	velocity = direcao * move_speed
	move_and_slide()
	atingir_jogador()

func atingir_jogador():
	if raycast_3d.is_colliding() and raycast_3d.get_collider().has_method("derrota"):
		raycast_3d.get_collider().derrota()

func distrair():
	$RonromFX.play()
	#sprite.play("catronrom")
	$CollisionShape3D.set_process(false)
	distraido = true
