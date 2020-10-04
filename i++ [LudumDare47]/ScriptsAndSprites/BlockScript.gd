extends StaticBody2D

var activation_level=100
var x=0.0
var y=0.0
var direction=Vector2(0.0, 0.0)
var roznica
var act_radius=48
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$CollisionShape2D.set_disabled(true)
	x=global_position.x
	y=global_position.y
	global_position.x=504
	roznica=504-x
	pass

func _physics_process(delta):
	if Auto.level==activation_level:
		if Auto.x<x-act_radius:
			$CollisionShape2D.set_disabled(true)
			global_position.x=x+(((Auto.x-x+act_radius)/(-x+act_radius+24)))*(480-x+24)
		if Auto.x>=x-act_radius&&Auto.x<=x+act_radius:
			global_position.x=x
			$CollisionShape2D.set_disabled(false)
		if Auto.x>x+act_radius:
			$CollisionShape2D.set_disabled(true)
			global_position.x=x-(((Auto.x-x-act_radius)/(480-x-act_radius-24))*(x+24))
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
