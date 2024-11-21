extends Node2D

onready var transition = get_node("transicao/ColorRect")
onready var animation = get_node("transicao/ColorRect/AnimationPlayer")

export (int, "Pixels", "Spot Player", "Spot Centero", "Corte Vertical", "Corte Horizontal") var transition_type
export (float,2.0)var duration = 1.0

func _ready():
	transition.material.set_shader_param("type", transition_type)
	animation.playback_speed = duration
