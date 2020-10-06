extends KinematicBody2D


var maxSpeed = 30
var accel = 200
var velocity = Vector2.ZERO
var knockback = Vector2.ZERO
onready var stats = $EnemyStats
onready var playerDetection = $PlayerDetection
onready var sprite = $AnimatedSprite

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
	knockback = move_and_slide(knockback)
	seek_player(delta)
	velocity = move_and_slide(velocity)

func seek_player(delta):
	if playerDetection.can_see_player():
		var player = playerDetection.player
		if player != null:
			var direction = (player.global_position - global_position).normalized()
			velocity = velocity.move_toward(direction * maxSpeed, accel * delta)
			

func create_boss_effect():
	var BossDeathEffect = load("res://instance/enemy/BossDeathEffect.tscn") 
	var bossDeathEffect = BossDeathEffect.instance()                        
	var jogo = get_tree().current_scene                             
	jogo.add_child(bossDeathEffect)                                     
	bossDeathEffect.global_position = global_position 

func _on_Hurtbox_area_entered(area):
	stats.health -= 1
	knockback = area.knockback_vector * 80

func _on_EnemyStats_no_health():
	create_boss_effect()
	queue_free()
	
