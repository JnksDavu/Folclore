extends Node2D

var onLivro = false


func _ready():
	$magias/livro.visible = false


func _on_magias_body_entered(body):
	onLivro = true


func _on_magias_body_exited(body):
	onLivro = false


func _process(delta):
	if onLivro and Input.is_action_just_pressed("interacao"):
		$magias/livro.visible = true
	if onLivro == false:
		$magias/livro.visible = false
