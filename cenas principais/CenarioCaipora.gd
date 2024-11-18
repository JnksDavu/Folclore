extends Node2D

var achou = false

func _ready():
	$Intera/achou/caipora.set_visible(false)
	$Intera/achou/java.set_visible(false)       
	
func _on_achou_body_entered(body):
	achou = true

func _on_achou_body_exited(body):
	achou = false
