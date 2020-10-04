extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var level=0
var MAX_SPEED=300
var ACCELERATION=20
var DEACCELERATION=10
var JUMP_HEIGHT=850
var JUMP_BOOST=50
var speed=0
var jump=0
var canplay=true
var FALL_SPEED=100
var UP=Vector2(0, -1)
var colorsave=Color(0, 0, 0, 0)
var end=false
# Called when the node enters the scene tree for the first time.
func _ready():
	if level!=0:
		Auto.points=level-1
	colorsave=get_modulate()
	pass # Replace with function body.

func _physics_process(delta):
	if level==50:
		$Hellyeah.volume_db-=0.1
	else:
		$Hellyeah.volume_db+=1
	$Hellyeah.volume_db=min($Hellyeah.volume_db, -30)
	$Hellyeah.volume_db=max($Hellyeah.volume_db, -80)
	if $Jumpsound.playing==false:
		canplay=true
	for body in $Detector.get_overlapping_areas():
		if body.is_in_group("Spike"):
			death()
			$CollisionShape2D.set_disabled(true)
			$Detector/CollisionShape2D.set_disabled(true)
	if global_position.x>480:
		level+=1
		level=min(level, Auto.points+1)
		global_position.x-=480
	if global_position.x<0:
		global_position.x+=480
		level-=1
	level=max(0, level)
	if level==0 && global_position.x<24:
		speed=-speed+50
	if Input.is_action_pressed("ui_right"):
		speed+=ACCELERATION
	elif Input.is_action_pressed("ui_left"):
		speed-=ACCELERATION
	else:
		if speed>0:
			speed=max(0, speed-DEACCELERATION)
		if speed<0:
			speed=min(0, speed+DEACCELERATION)
	if speed<-MAX_SPEED:
		speed=-MAX_SPEED
	if speed>MAX_SPEED:
		speed=MAX_SPEED
	
	if is_on_wall()==true:
		if !(Input.is_action_pressed("ui_left")) && !(Input.is_action_pressed("ui_left")):
			speed=0
			
	
	if Input.is_action_pressed("ui_up"):
		if is_on_floor()==true:
			playjump()
			jump=-JUMP_HEIGHT
		elif jump<0:
			jump-=JUMP_BOOST
	elif is_on_floor()==true:
		jump=10
	if is_on_floor()==false:
		jump+=FALL_SPEED
	if is_on_ceiling()==true:
		jump=20
	move_and_slide(Vector2(speed, jump), UP)
	Auto.x=global_position.x
	Auto.y=global_position.y
	Auto.level=level
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func death():
	$Hurt.play()
	modulate=Color(255, 0, 0, 255)
	var tween = get_node("Tween")
	tween.interpolate_property($".", "position",
	global_position, Vector2(24, 408), 0.25,
	Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	yield(get_tree().create_timer(0.25), "timeout")
	$CollisionShape2D.set_disabled(false)
	$Detector/CollisionShape2D.set_disabled(false)
	modulate=colorsave

func playjump():
	if canplay==true:
		$Jumpsound.play()
		canplay=false
