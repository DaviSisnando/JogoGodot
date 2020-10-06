extends Node2D


var rupeeCount = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Rupee_body_entered(body):
	rupeeCount += 1
	var rupee = get_node("Rupee")
	rupee.queue_free()
	if rupeeCount == 1:
		var rupee2 = get_node("Rupee2")
		rupee2.queue_free()
