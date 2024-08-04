extends AnimatedSprite2D

@onready var weapon = $BlasterSprite
var bullet = preload("res://scenes/bullet.tscn")
var fire_rate = 3.0
var cooldown = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	cooldown -= delta
	if Input.is_action_pressed("leftClick") and cooldown <= 0:
		weapon.play()
		var instance = bullet.instantiate()
		get_node("../..").add_child(instance)
		cooldown = 1.0 / fire_rate
		
	# Get the position of the mouse relative to the player
	var mouse_position = get_global_mouse_position()
	var direction = (mouse_position - global_position).normalized()

	# Calculate the angle to the mouse
	var target_angle = direction.angle()

	# Set the weapon's rotation to point towards the mouse
	weapon.rotation = target_angle + (PI/2)
	

	# Position the weapon at a fixed distance from the player, creating a circle around the player
	var distance_from_player = 15  # Adjust this value to set the radius of the circle
	weapon.position = Vector2(cos(target_angle), sin(target_angle)) * distance_from_player


func _on_player_frame_change(newFrame):
	frame = newFrame
	

