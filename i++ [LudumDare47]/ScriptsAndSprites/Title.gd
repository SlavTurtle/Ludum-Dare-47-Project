extends Sprite

var ye=0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	show()
	pass # Replace with function body.

func _process(delta):
	if ye==0:
		if Input.is_action_pressed("ui_right"):
			ye = 1
			begone()
			spinmebaby()

func begone():
	var tween = get_node("Tween")
	tween.interpolate_property($".", "scale",
	Vector2(1.0, 1.0), Vector2(1, 0), 1,
	Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()	
	
	yield(get_tree().create_timer(1), "timeout")
	queue_free()

func spinmebaby():
	var tween = get_node("Tween")
	tween.interpolate_property($".", "rotation_degrees",
	0, 360, 1,
	Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
