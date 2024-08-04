extends Sprite2D

var speed = 400
var angularSpeed = 1000
var scene = preload("res://bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
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
	
	look_at(get_viewport().get_mouse_position())
	
	if Input.is_action_just_pressed("leftClick"):
		var instance = scene.instantiate()
		get_node("..").add_child(instance)
	
