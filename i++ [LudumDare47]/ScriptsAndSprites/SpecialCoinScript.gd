extends StaticBody2D

var activation_level=100
var x=0.0
var y=0.0
var direction=Vector2(0.0, 0.0)
var roznica
var act_radius=48
var active=true
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D/CollisionShape2D.set_disabled(true)
	x=global_position.x
	y=global_position.y
	global_position.x=504
	roznica=504-x
	pass

func _physics_process(delta):
	for body in $Area2D.get_overlapping_bodies():
		if body.name=="Hero" && active==true:
			Auto.points+=1
			active=false
			music()
	if Auto.level==activation_level && active==true:
		global_position.y=min(y, Auto.y-96)
		if Auto.x<x-act_radius:
			$Area2D/CollisionShape2D.set_disabled(true)
			global_position.x=x+(((Auto.x-x+act_radius)/(-x+act_radius+24)))*(480-x+24)
		if Auto.x>=x-act_radius&&Auto.x<=x+act_radius:
			global_position.x=x
			$Area2D/CollisionShape2D.set_disabled(false)
		if Auto.x>x+act_radius:
			$Area2D/CollisionShape2D.set_disabled(true)
			global_position.x=x-(((Auto.x-x-act_radius)/(480-x-act_radius-24))*(x+24))
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func music():
	$CoinPickup.play()
	var tween = get_node("Tween")
	tween.interpolate_property($".", "position",
	global_position, Vector2(-24, 0), 0.25,
	Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()
	yield(get_tree().create_timer(0.3), "timeout")
	queue_free()
