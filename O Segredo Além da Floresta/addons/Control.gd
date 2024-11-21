extends Control

var Caixaatual = 0
var aux = 0

func _ready():
	pass
	#$TextureRect/DialogueBox.start()



func _on_DialogueBox_dialogue_proceeded():
	aux = Caixaatual
	Caixaatual = aux+1
	print(Caixaatual)
	match Caixaatual:
		1: menino()
		3: homen()
		7: menino()
		9: homen()
		13: menino()

func menino():
	$TextureRect/DialogueBox/Sprite2.set_visible(true)
	$TextureRect/DialogueBox/Sprite.set_visible(false)

func homen():
	$TextureRect/DialogueBox/Sprite2.set_visible(false)
	$TextureRect/DialogueBox/Sprite.set_visible(true)

func _on_DialogueBox_dialogue_started(id):
	Caixaatual = 2
	aux = 2

func _on_DialogueBox_dialogue_ended():
	set_physics_process(true)
	var tree = get_tree()
	var Batalha = "res://batalha/Battle.tscn"
	tree.change_scene(Batalha)
