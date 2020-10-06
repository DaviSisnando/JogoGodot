extends KinematicBody2D

class_name PhysicsBoxx


func push(velocity: Vector2):
	move_and_slide(velocity, Vector2())
