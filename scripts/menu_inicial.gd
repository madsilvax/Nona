extends Control

@onready var iniciar_btn = $MarginContainer/HBoxContainer/VBoxContainer/iniciar_btn

func _ready():
	iniciar_btn.grab_focus()

func _process(delta):
	pass

func _input(event):
	if event is InputEventKey or event.is_action_pressed("botoes mouse"):
		get_tree().change_scene_to_file("res://scenes/mundo.tscn")

func _on_iniciar_btn_pressed():
	get_tree().change_scene_to_file("res://scenes/mundo.tscn")

func _on_créditos_btn_pressed():
	pass

func _on_configurações_btn_pressed():
	pass

func _on_sair_btn_pressed():
	get_tree().quit()
