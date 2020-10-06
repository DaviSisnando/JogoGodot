extends KinematicBody2D

var push_speed = 50
const maxSpeed = 3000
var speed = Vector2.ZERO
var aux_vector = Vector2.ZERO
var hitpoint = PlayerHealth
var rupee = 0
onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var hitboxSword = $HitboxPivot/HitboxSword
onready var hurtbox = $Hurtbox

func _ready():
	#animationTree.active = true
	hitpoint.connect("no_health", self, "queue_free") #objeto que tem sinal, sinal que vai conectar, objeto que tem a função, função que ta conectando
	hitboxSword.knockback_vector = aux_vector
	
enum {
	MOVE,
	ATTACK
}

var state = MOVE


func _physics_process(delta):
	match state:
		MOVE:
			movimento(delta)
		ATTACK:
			attack(delta)

func movimento(delta):
	var move_direction = Vector2.ZERO
	move_direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	move_direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	move_direction = move_direction.normalized()
	
	if move_direction != Vector2.ZERO:
		aux_vector = move_direction  #se parar, vai lembrar a ultima posicao que o player estava andando
		hitboxSword.knockback_vector = move_direction
		animationTree.set("parameters/Idle/blend_position", move_direction)
		animationTree.set("parameters/Move/blend_position", move_direction)
		animationTree.set("parameters/Attack/blend_position", move_direction)
		animationState.travel("Move") #travel vai pro estado que eu quero da maquina de estado
		speed = move_direction * maxSpeed * delta

	else:
		animationState.travel("Idle")
		speed = Vector2.ZERO
		
	move_and_slide(speed)
	if get_slide_count() > 0:
		check_box_collision(move_direction)
		
	if Input.is_action_just_pressed("attack"):
		state = ATTACK

#	move_and_collide(move_direction.normalized() * speed * delta)

func attack(delta):
	animationState.travel("Attack")

func attackEnd(): #Funcao criada no final da animacao pra quando terminar, mudar a maquina de estado para "Move"
	state = MOVE 


func _on_Hurtbox_area_entered(area):
	hitpoint.health -= 1
	hurtbox.start_invincible(0.5)
	

func check_box_collision(move_direction: Vector2) -> void:
	if abs(move_direction.x) + abs(move_direction.y) > 1:
		return
	var box : = get_slide_collision(0).collider as PhysicsBox
	if box:
		box.push(push_speed * move_direction)



func _on_Rupee_body_entered(body):
	rupee += 5
	get_parent().get_parent().get_node("CanvasLayer/RupeeHud/Label").text = str(rupee)
	if rupee == 35:
		get_tree().change_scene("res://instance/menu/EndGame.tscn")
	#get_parent().get_parent().get_node("RupeeHud/Label").text = str(rupee)
