extends Node2D

var onPergas = false

func _ready():
	$pergas/pergas.visible = false
	

func _process(delta):
	if onPergas and Input.is_action_just_pressed("interacao"):
		$pergas/pergas.visible = true
	if onPergas == false:
		$pergas/pergas.visible = false


func _on_pergas_body_entered(body):
	onPergas = true


func _on_pergas_body_exited(body):
	onPergas = false
