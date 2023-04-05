extends KinematicBody2D

var velocity = Vector2.ZERO

const acceleration = 500
const friction = 500
const max_speed = 80

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

enum{
	move,
	roll,
	attack
}
var state = move

func _ready():
	animationTree.active = true
 
func _physics_process(delta):
	match state:
		move:
			move_state(delta)
		roll:
			pass
			
		attack:
			attack_state(delta)	
func move_state(delta):
	var input_vector = Vector2.ZERO
	
	#jump/ jogo de plataforma 
	#const gravity = 1800
	#var jump_force = -500
	#velocity.y += gravity * delta
	#if Input.is_action_just_pressed("ui_up") and is_on_wall(): #is_on_floor pq ele esta no chao, mas esta verificando o chao como parede
	#	velocity.y = jump_force 	
	#elif Input.is_action_just_released("ui_up") and velocity.y < 0:
	#	velocity *= 0.5	
		
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()		
			
	 
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationState.travel("Run")	
		
		velocity = velocity.move_toward(input_vector * max_speed, acceleration * delta)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
	
	if Input.is_action_just_pressed("Attack"):
		state = attack
		
	velocity = move_and_slide(velocity)
	
func attack_state(delta):
	animationState.travel("Attack")

func attack_animation_finished():
	state = move	
	
