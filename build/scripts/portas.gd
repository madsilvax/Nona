extends Node3D

@onready var jogador : CharacterBody3D = get_tree().get_first_node_in_group("Jogador")

var jogador_perto = false
var porta_aberta = false

func _input(event):
	if Input.is_action_just_pressed("interagir"):
		if jogador_perto == true and $AnimationPlayer.is_playing() == false:
			porta_aberta = !porta_aberta
			if porta_aberta == true:
				$AnimationPlayer.play("porta aberta")
				$PortaFX.play()
				
			else:
				$AnimationPlayer.play("porta fechada")
				$PortaFX.play()

func _on_Area_body_entered(body):
	if body.name == "Jogador":
		jogador_perto = true
		jogador.interagir_show()

func _on_Area_body_exited(body):
	if body.name == "Jogador":
		jogador_perto = false
		jogador.interagir_hide()
