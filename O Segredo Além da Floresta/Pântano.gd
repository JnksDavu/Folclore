extends Node2D


func _ready():
	$Profundidade/Player/Sim/LightOccluder2D.set_visible(false)
	$Profundidade/Player/Position2D/Lanterna.set_visible(false)
	$Profundidade/Player/interact_label.set_text("Ta ficando Escuro Mano, Aperta 'F'")
	yield(get_tree().create_timer(5), "timeout")
	$Profundidade/Player/interact_label.set_text("")


func _physics_process(delta):
	if Input.is_action_just_pressed("Lanterna"):
		if $Profundidade/Player/Position2D/Lanterna.is_visible() == true:
			$Profundidade/Player/Position2D/Lanterna.set_visible(false)
		else:
			$Profundidade/Player/Position2D/Lanterna.set_visible(true)
