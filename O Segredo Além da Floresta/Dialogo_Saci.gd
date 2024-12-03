extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_DialogueBox_dialogue_ended():
	set_physics_process(true)
	var tree = get_tree()
	var achacaipora = "res://batalha/batalha/batalha_saci/Battle_saci.tscn"
	tree.change_scene(achacaipora)
