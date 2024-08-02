extends CharacterBody3D

@onready var camera_3d = $Camera3D
@onready var raycast_3d = $RayCast3D
@onready var mao = $"UI jogador/MarginContainer/Pov/Mao"
@onready var menu = $"UI jogador/MarginContainer/Menu"
@onready var retomar_btn = $"UI jogador/MarginContainer/Menu/VBoxContainer/retomar_btn"
@onready var arremeessarFX = $"Efeitos Sonoros/ArremessarFX"

const SPEED = 2.0
const MOUSE_SENSITIVITY = 0.1

var pode_arremessar = true
var derrotado = false

func _ready():
	get_tree().call_group("Gatos", "set_camera", self)
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	mao.animation_finished.connect(arremessar_fim)
	menu.visible = false
	$"UI jogador/MarginContainer/Derrota/Panel/Button".button_up.connect(restart)

func _process(delta):
	if Input.is_action_just_pressed("arremessar"):
		arremessar()
	if derrotado:
		return

func _input(event):
	if derrotado:
		return
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * MOUSE_SENSITIVITY
		camera_3d.rotation_degrees.x -= event.relative.y * MOUSE_SENSITIVITY

func _unhandled_input(event):
	if event.is_action_pressed("menu"):
		get_tree().paused = true
		menu.visible = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		retomar_btn.grab_focus()

func _physics_process(delta):
	if derrotado:
		return
	var input_dir = Input.get_vector("move_esquerda", "move_direita", "move_frente", "move_tras")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func arremessar():
	if !pode_arremessar:
		return
	pode_arremessar = false
	mao.play("arremessar")
	arremeessarFX.play()
	if raycast_3d.is_colliding() and raycast_3d.get_collider().has_method("distrair"):
		raycast_3d.get_collider().distrair()

func arremessar_fim():
	pode_arremessar = true

func derrota():
	get_tree().paused = true
	derrotado = true
	$"UI jogador/MarginContainer/Derrota".show()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_retomar_btn_pressed():
	get_tree().paused = false
	menu.visible = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _on_reiniciar_btn_pressed():
	restart()

func _on_configurações_btn_pressed():
	pass # Replace with function body.

func _on_menu_inicial_btn_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/menu_inicial.tscn")

func _on_sair_btn_pressed():
	get_tree().quit()

func restart():
	get_tree().paused = false
	get_tree().reload_current_scene()
