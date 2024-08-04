extends Node2D

signal frameChange(newFrame)

var speed = 400
var health = 5
var power = 3
var range = 3
var timer = Timer.new()


func _ready():
	add_child(timer)
	timer.wait_time = 0.5
	timer.one_shot = false

func _process(delta):
	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("ui_up"):
		velocity += Vector2.UP * speed
	if Input.is_action_pressed("ui_down"):
		velocity += Vector2.DOWN * speed
	if Input.is_action_pressed("ui_left"):
		velocity += Vector2.LEFT * speed
	if Input.is_action_pressed("ui_right"):
		velocity += Vector2.RIGHT * speed
		
	position += velocity * delta
	playerLook()
	
	

func hurt(damage,knockback,direction):
	health -= damage
	print(health)
	position += Vector2.RIGHT.rotated(direction) * (70*knockback)

func playerLook():
	var facingAngle = position.angle_to_point(get_viewport().get_mouse_position())
	if facingAngle < 0:
		facingAngle = (2*PI) + facingAngle
		
	facingAngle = (2*PI) - facingAngle
	
	if PI*(3/4.0) < facingAngle && facingAngle < PI*(5/4.0):
		frameChange.emit(3)
	elif PI*(1/4.0) < facingAngle && facingAngle < PI*(3/4.0):
		frameChange.emit(1)
	elif PI*(5/4.0) < facingAngle && facingAngle < PI*(7/4.0):
		frameChange.emit(0)
	else:
		frameChange.emit(2)
		
func _on_area_2d_area_entered(area):
	pass
