extends Node2D

var onLivro = false


func _ready():
	$relogio.play()
	$ler/livros.visible = false


func _on_livro_body_entered(_body):
	onLivro = true
	print("verdade")

func _on_livro_body_exited(_body):
	 onLivro = false



func _on_ler_body_entered(body):
	onLivro = true
	


func _on_ler_body_exited(body):
	onLivro = false

func _process(delta):
	if onLivro and Input.is_action_just_pressed("interacao"):
		$ler/livros.visible = true
	if onLivro == false:
		$ler/livros.visible = false
