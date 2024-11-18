extends KinematicBody2D

var VELOCIDADE = Vector2.ZERO


const ACELERACAO = 250
const VELO_MAX = 100
const FRICCAO = 300


onready var animationPlayer = $AnimationPlayer
onready var animationtree = $AnimationTree
onready var animationState = animationtree.get("parameters/playback")

onready var all_interactions = []
onready var interact_label = $"interactioncomponenets/label interacap"
onready var cu_interaction = 0
onready var light: Light2D = $Lanterna

var zona_interacao := false


func _physics_process(delta):
	var input_vetor = Vector2.ZERO
	input_vetor.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vetor.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vetor = input_vetor.normalized()
	
	if input_vetor != Vector2.ZERO:
		animationtree.set("parameters/Correr/blend_position", input_vetor)
		animationtree.set("parameters/Idle/blend_position", input_vetor)
		animationState.travel("Correr")
		VELOCIDADE = VELOCIDADE.move_toward(input_vetor * VELO_MAX, ACELERACAO * delta)
	else:
		animationState.travel("Idle")
		VELOCIDADE = VELOCIDADE.move_toward(Vector2.ZERO, FRICCAO * delta)
	
	
	
	if VELOCIDADE.length() == 0:
		animationtree.set("parameters/Idle/blend_position", input_vetor)
	else:
		if $Sim/Timer.time_left <= 0:
			$Sim/StepFX.pitch_scale = rand_range(1.0, 1.3)
			$Sim/StepFX.play()
			$Sim/Timer.start(0.3)
			
	

	
	VELOCIDADE = move_and_slide(VELOCIDADE)
	

	if input_vetor != Vector2.ZERO:
		# Normalize a direção do movimento
		input_vetor = input_vetor.normalized()

		# Pega o ângulo de rotação em radianos
		var angle = input_vetor.angle_to(Vector2.RIGHT)
		if int(angle) < 1 && int(angle) > -1:
			match int(input_vetor.angle_to(Vector2.LEFT)):
				-2: $Position2D/Lanterna.set_rotation_degrees(135.00)
				2: $Position2D/Lanterna.set_rotation_degrees(-135.00)
				3: $Position2D/Lanterna.set_rotation_degrees(180.00)
		else:
			match int(input_vetor.angle_to(Vector2.RIGHT)):
				-3: $Position2D/Lanterna.set_rotation_degrees(0.00)
				-1: $Position2D/Lanterna.set_rotation_degrees(-90.00)
				1: $Position2D/Lanterna.set_rotation_degrees(90.00)
				2: $Position2D/Lanterna.set_rotation_degrees(45.00)
				-2: $Position2D/Lanterna.set_rotation_degrees(-45.00)
	
		
	#////////////////////////////////////////////////////////////////
	
		
	if Input.is_action_just_pressed("interacao"):
		executa_interacao()	


func _ready():
	executa_interacao()
	$NodeTransicao/transicao/ColorRect/AnimationPlayer.play("trasicao_out")

func _on_interacoes_area_entered(area):
	all_interactions.insert(0, area)
	update_interactions()
	zona_interacao = true
	

func _on_interacoes_area_exited(area):
	all_interactions.erase(area)
	update_interactions()
	zona_interacao = false

func update_interactions():
	if all_interactions:
		$interact_label.set_text(all_interactions[0].interact_label)
	else:
		$interact_label.set_text("")
				

#hud Interacao

func executa_interacao():
	if 	zona_interacao == true:
		cu_interaction = all_interactions[0]
		match cu_interaction.interact_type:
			"fala" : fala()
			"entracasa" : entracasa()
			"saicasa" : saicasa()
			"entraquarto" : entraquarto()
			"JuckBox": JuckBox()
			"Janela": $interact_label.set_text("Que bela Vista \n Realmente um belo dia")
			"roubo": $interact_label.set_text("Poxa vida meus pais \n voaram pela janela")
			"Cu": $CanvasLayer2/Dialogo_Curupira/TextureRect/DialogueBox.start()
			"CabanaFloresta": entraCabanaFloresta()
			"Relogio":$interact_label.set_text("Se eu soubesse ver a hora em relógios assim...")
			"Gaveta":$interact_label.set_text("A gaveta está vazia")
			"VoltaCenaCaipora": VoltaCenaCaipora()
			"cafe":$interact_label.set_text("Ah! O café ta frio...")
			"livro":livro()
			"comida":$interact_label.set_text("Ah! To sem fome...")
			"pato":$interact_label.set_text("QUACK!")
			"saicasaiara":saicasaiara()
			"entracasaiara":entracasaiara()
			"obelisco":$interact_label.set_text("OMG! Um grande obelisco de outro Mundo...")
			"casaDark":casaDark()
			"cripta":cripta()
			"darkForest":darkForest()
			"bau":$interact_label.set_text("Vazio!!")
			"arbusto":arbusto()
			"Caipora":caipora()
			"calderas":$interact_label.set_text("Que sopa mais diferente!!!")
			"caverna":caverna()
			"Boto": CenaBoto()
			"Saci": Saci()
			"CucaB":Cuca()
			
	else:
		pass


# funcoes de interacao
func CenaBoto():
	get_tree().change_scene("res://cenas principais/CenarioBoto.tscn")
	
func Saci():
	get_tree().change_scene("res://batalha/batalha/batalha_saci/Battle_saci.tscn")
	
func Cuca():
	get_tree().change_scene("res://batalha/batalha_cucas/Battle_cucaRA.tscn")

func fala():
	$CanvasLayer2/dialogo/TextureRect/DialogueBox.start()
	
func caipora():
	$CanvasLayer2/Dialogo_Caipora/TextureRect/DialogueBox.start()
	
func JuckBox():
	pass
	
func entracasa():
	get_tree().change_scene("res://cenas principais/Casa.tscn")
	
func saicasa():
	get_tree().change_scene("res://Exterior.tscn") 

func entraquarto():
	get_tree().change_scene("res://cenas principais/Quarto.tscn")

func entraCabanaFloresta():
	get_tree().change_scene("res://cenas principais/CabanaFloresta.tscn")

func VoltaCenaCaipora():
	get_tree().change_scene("res://cenas principais/CenarioCaipora.tscn")
	
func livro():
	get_tree().change_scene("res://cabanas/livro.tscn")	

func saicasaiara():
	get_tree().change_scene("res://cenas principais/Cenarioiara2.tscn")	
	
func entracasaiara():	
	get_tree().change_scene("res://cenas principais/CabanaLago.tscn")	
	
func pato():
	$sons/pato.play()	
	
func casaDark():
	get_tree().change_scene("res://cenas principais/DarkForest/CasaDarkForest.tscn")

func cripta():
	get_tree().change_scene("res://cenas principais/DarkForest/CriptaDarkForest.tscn")	
	
func darkForest():
	get_tree().change_scene("res://cenas principais/DarkForest/DarkForest.tscn")
	
func arbusto():
	$sons/arbusto.play()	
	
func caverna():
		get_tree().change_scene("res://cenas principais/DarkForest/CavernaCuCA.tscn")
#////////////////////////////////////////////////////////////////////
