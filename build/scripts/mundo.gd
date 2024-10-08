extends Node3D

@onready var jogador : CharacterBody3D = get_tree().get_first_node_in_group("Jogador")

func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_fim_body_entered(body):
	if body.name == "Jogador":
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		get_tree().change_scene_to_file("res://build/scenes/fim.tscn")
