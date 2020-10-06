extends Area2D

export var show_hit = true

var invincible = false setget set_invincible

signal invincible_start
signal invincible_end
onready var timer = $Timer

func set_invincible(value):
	invincible = value
	if invincible == true:
		emit_signal("invincible_start")
	else:
		emit_signal("invincible_end")

func _on_Hurtbox_area_entered(area):
	if show_hit:
		var HitEffect = load("res://instance/hurtboxAndHitbox/HitEffect.tscn")
		var hitEffect = HitEffect.instance()
		var jogo = get_tree().current_scene
		jogo.add_child(hitEffect)
		hitEffect.global_position = global_position

func start_invincible(duration):
	self.invincible = true #self pra chamar o setter
	timer.start(duration)

func _on_Timer_timeout():
	self.invincible = false


func _on_Hurtbox_invincible_start():
	set_deferred("monitorable", false) #atribui um novo valor, depois do loop do jogo


func _on_Hurtbox_invincible_end():
	set_deferred("monitorable", true)
