extends Node2D


func create_grass_effect():
	var GrassEffect = load("res://instance/grass/GrassEffect.tscn") #carrega a cena
	var grassEffect = GrassEffect.instance()                        #instancia
	var jogo = get_tree().current_scene                             #pegar acesso
	jogo.add_child(grassEffect)                                     #adiciona a cena ao nó que quiser, no caso o jogo
	grassEffect.global_position = global_position #global_position é a posição da grama // setar a posicao


func _on_Hurtbox_area_entered(area):
	create_grass_effect()
	queue_free()
