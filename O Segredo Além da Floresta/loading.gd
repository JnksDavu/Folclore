extends Node2D


func _ready():
	var timer = Timer.new()
	timer.wait_time = 3.0  # Tempo em segundos
	timer.one_shot = true  # Executa apenas uma vez
	add_child(timer)       # Adiciona o Timer à cena
	timer.connect("timeout", self, "_on_timeout")
	timer.start()

func _on_timeout():
	get_tree().change_scene("res://Exterior.tscn") 
