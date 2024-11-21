extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




func _on_DialogueBox_dialogue_ended():
	set_physics_process(true)
	var tree = get_tree()
	var caipora = "res://cenas principais/BatalhaIara/OpenWorldIara.tscn"
	tree.change_scene(caipora)
