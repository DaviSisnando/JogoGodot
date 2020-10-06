extends KinematicBody2D

enum {
	IDLE,
	WANDER,
	CHASE
}
var maxSpeed = 60
var accel = 250
var state = CHASE
var knockback = Vector2.ZERO
var velocity = Vector2.ZERO
onready var stats = $EnemyStats
onready var playerDetection = $PlayerDetection
onready var sprite = $AnimatedSprite

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
	knockback = move_and_slide(knockback)
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, 200 * delta)
			seek_player()
			
		WANDER:
			pass
			
		CHASE:
			var player = playerDetection.player
			if player != null:
				var direction = (player.global_position - global_position).normalized()
				velocity = velocity.move_toward(direction * maxSpeed, accel * delta)
			sprite.flip_h = velocity.x < 0
			
	velocity = move_and_slide(velocity)
	
func create_enemy_effect():
	var EnemyDeathEffect = load("res://instance/enemy/EnemyDeathEffect.tscn") 
	var enemyDeathEffect = EnemyDeathEffect.instance()                        
	var jogo = get_tree().current_scene                             
	jogo.add_child(enemyDeathEffect)                                     
	enemyDeathEffect.global_position = global_position 

func seek_player():
	if playerDetection.can_see_player():
		state = CHASE

func _on_Hurtbox_area_entered(area):
	stats.health -= 1
	knockback = area.knockback_vector * 130


func _on_EnemyStats_no_health():
	create_enemy_effect()
	queue_free()

