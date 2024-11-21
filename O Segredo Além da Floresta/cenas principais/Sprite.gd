extends Sprite




var personagens = []

func _ready():
	# cria um nó filho para conter os personagens
	var personagens_node = Node2D.new()
	add_child(personagens_node)
	
	# cria os personagens e adiciona à lista
	var personagem1 = load("res://personagem1.tscn").instance()
	personagens_node.add_child(personagem1)
	personagens.append(personagem1)
	
	var personagem2 = load("res://personagem2.tscn").instance()
	personagens_node.add_child(personagem2)
	personagens.append(personagem2)
	
	var personagem3 = load("res://personagem3.tscn").instance()
	personagens_node.add_child(personagem3)
	personagens.append(personagem3)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
