extends CharacterBody3D

@onready var camera_3d = $Camera3D
@onready var raycast_3d = $RayCast3D
@onready var mao = $"UI jogador/Pov/Mao"
@onready var arremeessarFX = $"Efeitos Sonoros/ArremessarFX"

const SPEED = 2.0
const MOUSE_SENSITIVITY = 0.1

var pode_arremessar = true
var derrotado = false

func _ready():
	get_tree().call_group("Gatos", "set_camera", self)
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	mao.animation_finished.connect(arremessar_fim)
	$"UI jogador/Derrota/Panel/Button".button_up.connect(restart)

func _input(event):
	if derrotado:
		return
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * MOUSE_SENSITIVITY
		camera_3d.rotation_degrees.x -= event.relative.y * MOUSE_SENSITIVITY

func _process(delta):
	if Input.is_action_just_pressed("sair"):
		get_tree().quit()
	if Input.is_action_just_pressed("reiniciar"):
		restart()
	if Input.is_action_just_pressed("arremessar"):
		arremessar()
	if derrotado:
		return

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

func restart():
	get_tree().reload_current_scene()

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
	pode_arremessar = false
	derrotado = true
	$"UI jogador/Derrota".show()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
