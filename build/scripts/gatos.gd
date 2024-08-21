extends CharacterBody3D

@onready var jogador : CharacterBody3D = get_tree().get_first_node_in_group("Jogador")
@onready var sprite = $GatosSprite/AnimationPlayer
@onready var alcance_de_ataque = $"Alcance de ataque"

const move_speed = 1.5
const campo_de_visao = 4.0

var distraido = false

func _physics_process(delta):
	if distraido:
		return
	if jogador == null:
		return
	
	velocity = Vector3.ZERO
	if global_position.distance_to(jogador.global_position) < campo_de_visao:
		if distraido == false:
			sprite.play("catwalk")
			var direcao = jogador.global_position - global_position
			direcao.y = 0.0
			direcao = direcao.normalized()
			velocity = direcao * move_speed
	
	move_and_slide()

func distrair():
	$RonromFX.play()
	sprite.play("catidle")
	$CollisionShape3D.set_process(false)
	distraido = true
	
func _on_alcance_de_ataque_body_entered(jogador):
	if distraido == false and jogador.has_method("derrota"):
		jogador.derrota()
