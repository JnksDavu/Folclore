var personagem = load("res://personagem.tscn").instance()

# Adicionar o personagem como um nó filho do container de personagens
var container_personagens = get_node("container_personagens")
container_personagens.add_child(personagem)
