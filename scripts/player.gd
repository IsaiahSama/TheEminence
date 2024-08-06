extends Node2D

signal frameChange(newFrame)

var speed = 400
var max_health = 5
var health = max_health
var power = 1
var range = 2
var timer = Timer.new()
var damaged = false
var dead = false

func _ready():
	add_child(timer)
	timer.wait_time = 0.5
	timer.one_shot = false
	#timer.timeout.connect(_on_timer_timeout)
	$"HUD".set_life(max_health)
	$"HUD".set_stats(max_health, range, power)

func _process(delta):
	var velocity = Vector2.ZERO
	
	if not dead:
		if Input.is_action_pressed("ui_up"):
			velocity += Vector2.UP * speed
		if Input.is_action_pressed("ui_down"):
			velocity += Vector2.DOWN * speed
		if Input.is_action_pressed("ui_left"):
			velocity += Vector2.LEFT * speed
		if Input.is_action_pressed("ui_right"):
			velocity += Vector2.RIGHT * speed
			
		position += velocity * delta
		if not damaged: playerLook()
	
	if health <= 0:
		death()
		
func ascend(stats):
	damaged = true
	max_health = stats[0]
	health = max_health
	range = stats[1]
	power = stats[2]
	
	$"PlayerSprite".play("ascend")
	$"HUD".set_stats(health, range, power)
	$"HUD".update_life(health)
	await $"PlayerSprite".animation_finished
	damaged = false
	$"PlayerSprite".play("default")
	print("New stats for player:")
	print("Health:", health)
	print("Range:", range)
	print("Power:", power)
	
func death():
	dead = true
	$PlayerSprite.play("death")
	timer.start()
	#await timer.timeout
	#TODO: End Game

func hurt(damage,knockback,direction):
	if not damaged and not dead:
		health -= damage
		print("Current Health: ", health)
		$"HUD".update_life(health)
		position += Vector2.RIGHT.rotated(direction) * (70*knockback)
		$PlayerSprite.play("damage")
		timer.start()
		damaged = true
		await timer.timeout
		damaged = false
		$PlayerSprite.play("default")

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
