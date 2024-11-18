extends Node2D

var personagens = []
var inimigos = []
var turno_atual = 0

# Função para criar os personagens
func criar_personagens():
	# Cria os personagens e adiciona à lista
	var personagem1 = load("res://personagem1.tscn").instance()
	personagens.append(personagem1)
	var personagem2 = load("res://personagem2.tscn").instance()
	personagens.append(personagem2)
	var personagem3 = load("res://personagem3.tscn").instance()
	personagens.append(personagem3)

# Função para criar os inimigos
func criar_inimigos():
	# Cria os inimigos e adiciona à lista
	var inimigo1 = load("res://inimigo1.tscn").instance()
	inimigos.append(inimigo1)
	var inimigo2 = load("res://inimigo2.tscn").instance()
	inimigos.append(inimigo2)
	var inimigo3 = load("res://inimigo3.tscn").instance()
	inimigos.append(inimigo3)

# Função para trocar os turnos
func trocar_turno():
	# Incrementa o turno atual
	turno_atual += 1
	# Verifica se chegou ao fim dos turnos
	if turno_atual >= len(personagens) + len(inimigos):
		turno_atual = 0
	# Verifica se o personagem atual está vivo
	if turno_atual < len(personagens) and personagens[turno_atual].vida <= 0:
		trocar_turno()
	# Verifica se o inimigo atual está vivo
	if turno_atual >= len(personagens) and inimigos[turno_atual - len(personagens)].vida <= 0:
		trocar_turno()

# Função para executar a ação do personagem
func executar_acao_personagem(personagem, acao, alvo):
	# Executa a ação do personagem no alvo
	# Reduz a vida do alvo de acordo com o dano da ação

# Função para executar a ação do inimigo
func executar_acao_inimigo(inimigo, alvo):
	# Escolhe aleatoriamente uma ação para executar no alvo
	# Reduz a vida do alvo de acordo com o dano da ação

# Função para verificar se a batalha acabou
func verificar_fim_batalha():
	# Verifica se todos os personagens estão mortos
	var personagens_vivos = 0
	for personagem in personagens:
		if personagem.vida > 0:
			personagens_vivos += 1
	if personagens_vivos == 0:
		# O jogador perdeu a batalha
		# Exibe uma mensagem de derrota e volta para a tela de título
		pass
	# Verifica se todos os inimigos estão mortos
	var inimigos_vivos = 0
	for inimigo in inimigos:
		if inimigo.vida > 0:
			inimigos_vivos += 1
	if inimigos_vivos == 0:
		# O jogador venceu a batalha
		# Exibe uma mensagem de
		

func _ready():
	pass # Replace with function body.

