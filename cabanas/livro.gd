extends Node2D

func _ready():
	#$CabanaFloresta/Player.set_physics_process(false) 
	$Label1.visible = true
	$Label2.visible = true
	$Label3.visible = false
	$Label4.visible = false
func _process(delta):	
	if Input.is_action_just_pressed("ui_up"):
		$Label1.visible = false
		$Label2.visible = false	
		$Label3.visible = true
		$Label4.visible = true
	if Input.is_action_just_pressed("ui_down"):
		$Label1.visible = true
		$Label2.visible = true
		$Label3.visible = false
		$Label4.visible = false
		
	
