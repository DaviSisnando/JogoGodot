extends Area2D

var player = null

func can_see_player():   #se o player = null, retorna falso(nao da pra ver), se não for nulo é true (da pra ver)
	return player != null

func _on_PlayerDetection_body_entered(body):
	player = body


func _on_PlayerDetection_body_exited(body):
	player = null
