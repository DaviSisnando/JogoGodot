extends AnimatedSprite


func _ready():
	connect("animation_finished", self, "_on_animation_finished") #objeto ou nó que tem o sinal, sinal pra conectar, objeto ou nó que tem a função, a função que estamos conectando
	play("Animate")

func _on_animation_finished():
	queue_free()
	
