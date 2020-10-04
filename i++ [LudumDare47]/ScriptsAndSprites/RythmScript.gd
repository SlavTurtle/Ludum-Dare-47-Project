extends StaticBody2D

var activation_level=100
var x=0.0
var y=0.0
var direction=Vector2(0.0, 0.0)
var roznica
var act_radius=48
export var Time=3
var a=self_modulate.a
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	blink()
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
			if modulate.a==a:
				$CollisionShape2D.set_disabled(false)
		if Auto.x>x+act_radius:
			$CollisionShape2D.set_disabled(true)
			global_position.x=x-(((Auto.x-x-act_radius)/(480-x-act_radius-24))*(x+24))
			
func blink():
	if Auto.level==activation_level:
		$Area2D/CollisionShape2D.set_disabled(false)
	else:
		$CollisionShape2D.set_disabled(true)
	yield(get_tree().create_timer(0.1), "timeout")
	if Auto.level==activation_level:
		$CollisionShape2D.set_disabled(false)
	else:
		$CollisionShape2D.set_disabled(true)
	$Area2D/CollisionShape2D.set_disabled(true)
	modulate.a=a
	if Auto.level==activation_level:
		$Change.play()
	yield(get_tree().create_timer(1.4), "timeout")
	
	$Area2D/CollisionShape2D.set_disabled(true)
	$CollisionShape2D.set_disabled(true)
	modulate.a=a/4
	if Auto.level==activation_level:
		$Change.play()
	yield(get_tree().create_timer(1.5), "timeout")
	blink()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
