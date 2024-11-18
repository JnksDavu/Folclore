extends Area2D

onready var animp = $AnimationPlayer
var sensor = 0


func _process(delta):
	if sensor == 1:
		if Input.is_action_just_pressed("ui_left"):
			if Global.life == Global.max_life:
				Global.life+=0
				animp.play("good")
			else:
				Global.life+=10
				animp.play("good")
	if sensor == 0:
		if Input.is_action_just_pressed("ui_left"):
				Global.life-=10	
				animp.play("bad")
func _on_idleL_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	sensor = 1
	Global.sensor_mL = 1

func _on_idleL_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	sensor = 0
	Global.sensor_mL = 0
