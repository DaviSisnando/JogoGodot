extends Node

export var max_health = 1
var health = max_health setget set_health #toda vida que health mudar


signal no_health
signal health_change(value)


func set_health(value): #quando health mudar vai pra função automaticamente
	health = value
	emit_signal("health_change", health)
	if health <= 0:
		emit_signal("no_health")

func _ready():
	self.health = max_health
