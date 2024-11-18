extends Node2D



func _ready():
	$AnimationPlayer.play("BotoNadaIara")



func _on_AnimationPlayer_animation_finished(anim_name):
	$CanvasLayer/Control/TextureRect/DialogueBox.start()
