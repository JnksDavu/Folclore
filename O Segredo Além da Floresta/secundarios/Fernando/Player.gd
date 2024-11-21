extends KinematicBody2D

var VELOCIDADE = Vector2.ZERO

const ACELERACAO = 250
const VELO_MAX = 100
const FRICCAO = 300

onready var animationPlayer = $AnimationPlayer
onready var animationtree = $AnimationTree
onready var animationState = animationtree.get("parameters/playback")

onready var all_interactions = []
onready var interact_label = $interactioncomponenets/Label
onready var cu_interaction = 0
var zona_interacao := false


func _physics_process(delta):
	var input_vetor = Vector2.ZERO
	input_vetor.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vetor.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vetor = input_vetor.normalized()
	
	if input_vetor != Vector2.ZERO:
		animationtree.set("parameters/Correr/blend_position", input_vetor)
		animationtree.set("parameters/Idle/blend_position", input_vetor)
		animationState.travel("Correr")
		VELOCIDADE = VELOCIDADE.move_toward(input_vetor * VELO_MAX, ACELERACAO * delta)
	else:
		animationState.travel("Idle")
		VELOCIDADE = VELOCIDADE.move_toward(Vector2.ZERO, FRICCAO * delta)
	
	VELOCIDADE = move_and_slide(VELOCIDADE)
		
	#////////////////////////////////////////////////////////////////
	
		
	if Input.is_action_just_pressed("interacao"):
		executa_interacao()	
	
func _ready():
	executa_interacao()
	
func _on_interacoes_area_entered(area):
	all_interactions.insert(0, area)
	update_interactions()
	zona_interacao = true
	

func _on_interacoes_area_exited(area):
	all_interactions.erase(area)
	update_interactions()
	zona_interacao = false

func update_interactions():
	if all_interactions:
		interact_label.text = all_interactions[0].interact_label
	else:
		interact_label.text = ""

func executa_interacao():
	if 	zona_interacao == true:
		cu_interaction = all_interactions[0]
		match cu_interaction.interact_type:
			"fala" : $Dialogo/dialogo/TextureRect/DialogueBox.start()
			"entracasa" : get_tree().change_scene("res://Casa.tscn")
			"saicasa" : get_tree().change_scene("res://Exterior eu acho.tscn")
			"entraquarto" : get_tree().change_scene("res://Quarto.tscn")
	else:
		$CanvasLayer/dialogo/TextureRect/DialogueBox.stop()
