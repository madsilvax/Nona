extends Area3D

const rotacao = 50.0

var posicao_inicial = position.y
var posicao_final = position.y + 0.2

func _ready():
	var balanco_do_novelo = create_tween().set_loops().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	balanco_do_novelo.tween_property(self, "position:y", posicao_final, 1.0).from(posicao_inicial)
	balanco_do_novelo.tween_property(self, "position:y", posicao_inicial, 1.0).from(posicao_final)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotate_y(deg_to_rad(rotacao * delta))


func _on_body_entered(body):
	if body.name == "Jogador":
		body.coletar_novelos()
		queue_free()
