extends Area2D

var sensor = 0

func _process(delta):
	position.y -= Global.speed * delta
	
	if position.y < -50:
		queue_free()
		
	if sensor == 1:
		if Global.sensor_mU == 1:
			if Input.is_action_just_pressed("ui_up"):
				queue_free() 

func _on_moveU_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	sensor = 1


func _on_moveU_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	sensor = 0
