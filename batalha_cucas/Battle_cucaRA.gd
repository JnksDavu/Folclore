extends Control

signal textbox_closed

var cura
var enemy_health = 180
var enemy_damage = 16
var enemy_crit_chance = 9
var enemy_crit_min = 2.5
var enemy_crit_max = 2.0
var enemy_energy = 100
var enemy_max_energy = 100

var current_health = 125
var max_health = 125
var damage = 11
var crit_chance = 8
var crit_min = 1.5
var crit_max = 2.2
var energy = 100
var max_energy = 100


var defesa = false
export(Resource) var enemy = null
var current_player_health = 0
var current_enemy_health = 0
var energy_player = 0
var energy_enemy = 0
var energy_atack
var multiplicador = 1.0
var mira



func _ready():
	$Text_box.hide()
	esconde_opcoes()
	esconde_atack()
	esconde_defesa()
	display_text("CUCA A BRUXA TE DESAFIA")
	yield(self,"textbox_closed")
	mostra_opcoes()
	set_health($EnemyData/VidaInimigo , enemy_health , enemy_health)
	set_health($PlayerData/Vida_Player , current_health, max_health)
	set_energy($EnemyData/Estamina , enemy_energy,enemy_max_energy)
	set_energy($PlayerData/Estamina , energy,max_energy)
	current_player_health = current_health
	current_enemy_health = enemy_health
	energy_enemy = enemy_energy
	energy_player = energy
	
func esconde_opcoes():
	var opcoes = $AcoesPanel/acoes
	opcoes.visible = false

func mostra_opcoes():
	var opcoes = $AcoesPanel/acoes
	opcoes.visible = true
	
func esconde_atack():
	$Ataques/Ataque1.hide()
	$Ataques/Ataque2.hide()
	$Ataques/Ataque3.hide()
	$Ataques/Ataque4.hide()
	$Ataques/voltar.hide()

func mostra_atack():
	$Ataques/Ataque1.show()
	$Ataques/Ataque2.show()
	$Ataques/Ataque3.show()
	$Ataques/Ataque4.show()
	$Ataques/voltar.show()
	
	
func esconde_defesa():
	$Defesas/estamina.hide()
	$Defesas/cura.hide()
	$Defesas/Voltar_cura.hide()
		
func mostra_defesa():
	$Defesas/estamina.show()
	$Defesas/cura.show()
	$Defesas/Voltar_cura.show()

	
func display_text(text):
		$Text_box.show()
		$Text_box/Label.text = text
		
		
func _input(event):
	if(Input.is_action_just_pressed("ui_accept") or Input.is_mouse_button_pressed(BUTTON_LEFT)):
		$Text_box.hide()
		emit_signal("textbox_closed")
	
func set_health(progress_bar,health,max_health):
	progress_bar.value = health
	progress_bar.max_value = max_health
	progress_bar.get_node("Label").text = "HP:%d/%d" % [health,max_health]
	
func set_energy(progress_bar,energy,max_energy):
	progress_bar.value = energy
	progress_bar.max_value = max_energy
	progress_bar.get_node("Label").text = "EP:%d/%d" % [energy,max_energy]

func recarga_energia_aliado():
	if (energy_player <=max_energy):
		energy_player = max(0,energy_player + 10)
		set_energy($PlayerData/Estamina,energy_player,energy)
	
func recarga_energia_inimigo():
	energy_enemy = max(0,energy_enemy + 30)
	set_energy($EnemyData/Estamina,energy_enemy,enemy_energy)
	
func recarga_energia_defesa():
		energy_player = max(0,energy_player + 50)
		if(energy_player >max_energy):
			display_text("ENERGIA MAXIMA")
			yield(self,"textbox_closed")
			var diff = energy_player - max_energy
			energy_player = max(0,energy_player - diff)
			set_energy($PlayerData/Estamina,energy_player,energy)
		else:
			set_energy($PlayerData/Estamina,energy_player,energy)
	

func enemy_turn():

				var aleatorio = int(rand_range(1,3))
				if(aleatorio == 1):
					energy_atack = 30
					if(energy_enemy<energy_atack):
						display_text("CUCA ESTA SEM ESTAMINA")
						yield(self,"textbox_closed")
						recarga_energia_inimigo()
					
					else:
						mira = 70
						if rand_range(0, 99) > mira:
							display_text("CUCA ERROU O RABADA")
							energy_enemy = max(0,energy_enemy - energy_atack)
							set_energy($EnemyData/Estamina,energy_enemy,enemy_energy)
							yield(self,"textbox_closed")
							recarga_energia_inimigo()
						else:
							if rand_range(0, 99) < enemy_crit_chance:
								energy_enemy = max(0,energy_enemy - energy_atack)
								set_energy($EnemyData/Estamina,energy_enemy,enemy_energy)
								multiplicador = rand_range(enemy_crit_min, enemy_crit_max)
								var dano_final = (enemy_damage * multiplicador) +5
								current_player_health = max(0,current_player_health - dano_final)
								set_health($PlayerData/Vida_Player,current_player_health,max_health)
								display_text("CUCA \nRABADA\n e DEU UM \n ATAQUE CRITICO \n" + str(int(dano_final + 5)) +" Dano" )
								recarga_energia_inimigo()
								if(current_player_health==0):
									display_text("Seu inimigo te matou!")
									yield(self,"textbox_closed")
									get_tree().change_scene("res://cenas principais/DarkForest/CavernaCuCA.tscn")
							else:
								energy_enemy = max(0,energy_enemy - energy_atack)
								set_energy($EnemyData/Estamina,energy_enemy,enemy_energy)
								current_player_health = max(0,current_player_health - enemy_damage - 5)
								set_health($PlayerData/Vida_Player,current_player_health,max_health)
								display_text("CUCA atacou com RABADA\n" + str(enemy_damage +5) +" Dano" )
								recarga_energia_inimigo()
								if(current_player_health==0):
									display_text("Você MORREU!")
									yield(self,"textbox_closed")
									get_tree().change_scene("res://cenas principais/DarkForest/CavernaCuCA.tscn")
									
				if(aleatorio == 2):
					energy_atack = 40
					if(energy_enemy<energy_atack):
						display_text("CUCA ESTA SEM ESTAMINA")
						yield(self,"textbox_closed")
						recarga_energia_inimigo()
					
					else:
						mira = 45
						if rand_range(0, 99) > mira:
							display_text("CUCA ERROU O ATAQUE\n FEITIÇO")
							energy_enemy = max(0,energy_enemy - energy_atack)
							set_energy($EnemyData/Estamina,energy_enemy,enemy_energy)
							yield(self,"textbox_closed")
							recarga_energia_inimigo()
						else:
							if rand_range(0, 99) < enemy_crit_chance:
								energy_enemy = max(0,energy_enemy - energy_atack)
								set_energy($EnemyData/Estamina,energy_enemy,enemy_energy)
								multiplicador = rand_range(enemy_crit_min, enemy_crit_max)
								var dano_final = (enemy_damage * multiplicador)+18
								current_player_health = max(0,current_player_health - dano_final)
								set_health($PlayerData/Vida_Player,current_player_health,max_health)
								display_text("CUCA usou \nINVESTIDA e DEU UM \n ATAQUE CRITICO \n" + str(int(dano_final)) +" Dano" )
								recarga_energia_inimigo()
								if(current_player_health==0):
									display_text("CUCA te matou!")
									yield(self,"textbox_closed")
									get_tree().change_scene("res://cenas principais/DarkForest/CavernaCuCA.tscn")
							else:
								energy_enemy = max(0,energy_enemy - energy_atack)
								set_energy($EnemyData/Estamina,energy_enemy,enemy_energy)
								current_player_health = max(0,current_player_health - enemy_damage-8)
								set_health($PlayerData/Vida_Player,current_player_health,max_health)
								display_text("CUCA atacou com \nFEITIÇO\n" + str(enemy_damage+8) +" Dano" )
								recarga_energia_inimigo()
								if(current_player_health==0):
									display_text("Você MORREU!")
									yield(self,"textbox_closed")
									get_tree().change_scene("res://cenas principais/DarkForest/CavernaCuCA.tscn")		
					
				if(aleatorio == 3):
					energy_atack = 15
					if(energy_enemy<energy_atack):
						display_text("CUCA ESTA SEM ESTAMINA")
						yield(self,"textbox_closed")
						recarga_energia_inimigo()
					
					else:
						mira = 95
						if rand_range(0, 99) > mira:
							display_text("CUCA ERROU O FEITIÇO \nDENTADA")
							energy_enemy = max(0,energy_enemy - energy_atack)
							set_energy($EnemyData/Estamina,energy_enemy,enemy_energy)
							yield(self,"textbox_closed")
							recarga_energia_inimigo()
						else:
							if rand_range(0, 99) < enemy_crit_chance:
								energy_enemy = max(0,energy_enemy - energy_atack)
								set_energy($EnemyData/Estamina,energy_enemy,enemy_energy)
								multiplicador = rand_range(enemy_crit_min, enemy_crit_max)
								var dano_final = (enemy_damage * multiplicador) 
								current_player_health = max(0,current_player_health - dano_final)
								set_health($PlayerData/Vida_Player,current_player_health,max_health)
								display_text("CUCA usou\nDENTADA\n e DEU UM \n ATAQUE CRITICO \n" + str(int(dano_final + 20)) +" Dano" )
								recarga_energia_inimigo()
								if(current_player_health==0):
									display_text("CUCA te matou!")
									yield(self,"textbox_closed")
									get_tree().change_scene("res://cenas principais/DarkForest/CavernaCuCA.tscn")
							else:
								energy_enemy = max(0,energy_enemy - energy_atack)
								set_energy($EnemyData/Estamina,energy_enemy,enemy_energy)
								current_player_health = max(0,current_player_health - enemy_damage)
								set_health($PlayerData/Vida_Player,current_player_health,max_health)
								display_text("CUCA atacou com DENTADA\n" + str(enemy_damage) +" Dano" )
								recarga_energia_inimigo()
								if(current_player_health==0):
									display_text("Você MORREU!")
									yield(self,"textbox_closed")
									get_tree().change_scene("res://cenas principais/DarkForest/CavernaCuCA.tscn")
func _on_Ataque_pressed():
	esconde_opcoes()
	mostra_atack()



func _on_Ataque2_pressed():
		energy_atack = 40
		if(energy_player<energy_atack):
			display_text("VOCE ESTA SEM ESTAMINA SUFICIENTE")
			yield(self,"textbox_closed")
			recarga_energia_aliado()
			enemy_turn()
		else:
			mira = 65
			if rand_range(0, 99) > mira:
				display_text("VOCE ERROU O ATAQUE")
				energy_player = max(0,energy_player - energy_atack)
				set_energy($PlayerData/Estamina,energy_player,energy)
				yield(self,"textbox_closed")
				recarga_energia_aliado()
				enemy_turn()
			else:
				if rand_range(0, 99) < crit_chance:
					energy_player = max(0,energy_player - energy_atack)
					set_energy($PlayerData/Estamina,energy_player,energy)
					multiplicador = rand_range(crit_min, crit_max)
					var dano_final = (damage * multiplicador) + 8
					current_enemy_health = max(0,current_enemy_health - dano_final)
					set_health($EnemyData/VidaInimigo,current_enemy_health,enemy_health)
					display_text("Você atacou e Deu um \n ATAQUE CRITICO \n" + str(int(dano_final + 8)) +" Dano" )
					yield(self,"textbox_closed")
					if(current_enemy_health==0):
							display_text("CUCA DERROTADA")
							yield(self,"textbox_closed")
							get_tree().change_scene("res://cenas principais/DarkForest/DarkForest.tscn")
					else:
						enemy_turn()
						recarga_energia_aliado()
				else:
					energy_player = max(0,energy_player - energy_atack)
					set_energy($PlayerData/Estamina,energy_player,energy)
					current_enemy_health = max(0,current_enemy_health - (damage+20))
					set_health($EnemyData/VidaInimigo,current_enemy_health,enemy_health)
					display_text("Você atacou \n" + str(damage +8 ) +" Dano" )
					yield(self,"textbox_closed")
					recarga_energia_aliado()
					if(current_enemy_health==0):

							display_text("CUCA DERROTADA")
							yield(self,"textbox_closed")
							get_tree().change_scene("res://cenas principais/DarkForest/DarkForest.tscn")
					else:
						enemy_turn()
						recarga_energia_aliado()
		


func _on_Ataque1_pressed():
	if(cura == null):
		energy_atack = 30
		if(energy_player<energy_atack):
			display_text("VOCE ESTA SEM ESTAMINA SUFICIENTE")
			yield(self,"textbox_closed")
			recarga_energia_aliado()
			enemy_turn()
		else:
			mira = 80
			if rand_range(0, 99) > mira:
				display_text("VOCE ERROU O ATAQUE")
				energy_player = max(0,energy_player - energy_atack)
				set_energy($PlayerData/Estamina,energy_player,energy)
				yield(self,"textbox_closed")
				recarga_energia_aliado()
				enemy_turn()
			else:
				if rand_range(0, 99) < crit_chance:
					energy_player = max(0,energy_player - energy_atack)
					set_energy($PlayerData/Estamina,energy_player,energy)
					multiplicador = rand_range(crit_min, crit_max)
					var dano_final = (damage * multiplicador) + 10
					current_enemy_health = max(0,current_enemy_health - dano_final)
					set_health($EnemyData/VidaInimigo,current_enemy_health,enemy_health)
					display_text("Você atacou e Deu um \n ATAQUE CRITICO \n" + str(int(dano_final+10)) +" Dano" )
					yield(self,"textbox_closed")
					if(current_enemy_health==0):
							display_text("CUCA DERROTADA")
							yield(self,"textbox_closed")
							get_tree().change_scene("res://cenas principais/DarkForest/DarkForest.tscn")
					else:
						enemy_turn()
						recarga_energia_aliado()
				else:
					energy_player = max(0,energy_player - energy_atack)
					set_energy($PlayerData/Estamina,energy_player,energy)
					current_enemy_health = max(0,current_enemy_health - (damage + 10))
					set_health($EnemyData/VidaInimigo,current_enemy_health,enemy_health)
					display_text("Você atacou \n" + str(damage+10) +" Dano" )
					yield(self,"textbox_closed")
					if(current_enemy_health==0):
							display_text("CUCA DERROTADA")
							yield(self,"textbox_closed")
							get_tree().change_scene("res://cenas principais/DarkForest/DarkForest.tscn")
					else:
						enemy_turn()
						recarga_energia_aliado()
			if(cura == true):
				display_text("SEU PERSONAGEM ESTA CANSADO \n ESPERE O PROXIMO TURNO")
				yield(self,"textbox_closed")
				cura == null

func _on_Ataque4_pressed():
	energy_atack = 13
	if(energy_player<energy_atack):
		display_text("VOCE ESTA SEM ESTAMINA SUFICIENTE")
		yield(self,"textbox_closed")
		recarga_energia_aliado()
		enemy_turn()
		recarga_energia_aliado()
	else:
		mira = 98
		if rand_range(0, 99) > mira:
			display_text("VOCE ERROU O ATAQUE")
			energy_player = max(0,energy_player - energy_atack)
			set_energy($PlayerData/Estamina,energy_player,energy)
			yield(self,"textbox_closed")
			recarga_energia_aliado()
			enemy_turn()
			recarga_energia_aliado()
		else:
		
			if rand_range(0, 99) < crit_chance:
				energy_player = max(0,energy_player - energy_atack)
				set_energy($PlayerData/Estamina,energy_player,energy)
				multiplicador = rand_range(crit_min, crit_max)
				var dano_final = (damage * multiplicador)
				current_enemy_health = max(0,current_enemy_health - dano_final)
				set_health($EnemyData/VidaInimigo,current_enemy_health,enemy_health)
				display_text("Você atacou e Deu um \n ATAQUE CRITICO \n PEGOU NO OLHO \n" + str(int(dano_final)) +" Dano" )
				yield(self,"textbox_closed")
				if(current_enemy_health==0):
							display_text("CUCA DERROTADA")
							yield(self,"textbox_closed")
							get_tree().change_scene("res://cenas principais/DarkForest/DarkForest.tscn")
							
				else:
					enemy_turn()
					recarga_energia_aliado()
			else:
				energy_player = max(0,energy_player - energy_atack)
				set_energy($PlayerData/Estamina,energy_player,energy)
				current_enemy_health = max(0,current_enemy_health - damage)
				set_health($EnemyData/VidaInimigo,current_enemy_health,enemy_health)
				display_text("Você atacou \n" + str(damage) +" Dano" )
				yield(self,"textbox_closed")
				if(current_enemy_health==0):
							display_text("CUCA DERROTADA")
							yield(self,"textbox_closed")
							get_tree().change_scene("res://cenas principais/DarkForest/DarkForest.tscn")
				else:
					enemy_turn()
					recarga_energia_aliado()



func _on_Ataque3_pressed():
	energy_atack = 20
	if(energy_player<energy_atack):
		display_text("VOCE ESTA SEM ESTAMINA SUFICIENTE")
		yield(self,"textbox_closed")
		recarga_energia_aliado()
		enemy_turn()
		recarga_energia_aliado()
	else:
		mira = 75
		if rand_range(0, 99) > mira:
			display_text("VOCE ERROU O ATAQUE")
			energy_player = max(0,energy_player - energy_atack)
			set_energy($PlayerData/Estamina,energy_player,energy)
			yield(self,"textbox_closed")
			recarga_energia_aliado()
			enemy_turn()
			recarga_energia_aliado()
		else:
			if rand_range(0, 99) < crit_chance:
				energy_player = max(0,energy_player - energy_atack)
				set_energy($PlayerData/Estamina,energy_player,energy)
				multiplicador = rand_range(crit_min, crit_max)
				var dano_final = damage * multiplicador + 15
				current_enemy_health = max(0,current_enemy_health - dano_final)
				set_health($EnemyData/VidaInimigo,current_enemy_health,enemy_health)
				display_text("Você atacou e Deu um \n ATAQUE CRITICO \n" + str(int(dano_final+15)) +" Dano" )
				yield(self,"textbox_closed")
				if(current_enemy_health==0):
							display_text("CUCA DERROTADA")
							yield(self,"textbox_closed")
							get_tree().change_scene("res://cenas principais/DarkForest/DarkForest.tscn")
				else:
					enemy_turn()
					recarga_energia_aliado()
			else:
				energy_player = max(0,energy_player - energy_atack)
				set_energy($PlayerData/Estamina,energy_player,energy)
				current_enemy_health = max(0,current_enemy_health - (damage+15))
				set_health($EnemyData/VidaInimigo,current_enemy_health,enemy_health)
				display_text("Você atacou \n" + str(damage+15) +" Dano" )
				yield(self,"textbox_closed")
				if(current_enemy_health==0):
							display_text("CUCA DERROTADA")
							yield(self,"textbox_closed")
							get_tree().change_scene("res://cenas principais/DarkForest/DarkForest.tscn")
				else:
					enemy_turn()
					recarga_energia_aliado()
		



func _on_Defesa_pressed():
	esconde_opcoes()
	mostra_defesa()

func _on_voltar_pressed():
	esconde_atack()
	esconde_defesa()
	mostra_opcoes()


func _on_cura_pressed():
	if (current_player_health == max_health): 
		display_text("Sua Vida Esta no Maximo")
		yield(self,"textbox_closed")
		defesa = true
		enemy_turn()
		
	else:
		display_text("você ira se curar")
		yield(self,"textbox_closed")
		recarga_energia_defesa()
		cura = true 
		if((current_player_health + 50)<=max_health):
			current_player_health = max(0,current_player_health + 50)
			set_health($PlayerData/Vida_Player,current_player_health,max_health)
			enemy_turn()
		else:

			current_player_health = max_health

			set_health($PlayerData/Vida_Player, current_player_health, max_health)
			enemy_turn()

func _on_estamina_pressed():
	if (energy_player >=100): 
		display_text("Sua energia está no maximo")
		yield(self,"textbox_closed")
		defesa = true
		enemy_turn()
		
	else:
		display_text("Sua energia ira recuperar")
		yield(self,"textbox_closed")
		recarga_energia_defesa()
		enemy_turn()


func _on_Voltar_cura_pressed():
	esconde_defesa()
	mostra_opcoes()
