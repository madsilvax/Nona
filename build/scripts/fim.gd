extends Control

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_button_pressed():
	get_tree().change_scene_to_file("res://build/scenes/menu_inicial.tscn")
