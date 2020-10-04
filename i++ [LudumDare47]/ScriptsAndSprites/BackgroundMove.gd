extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	rotation_degrees+=0.1
	$Background.rotation_degrees-=0.1
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
