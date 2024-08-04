extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var blaster_sprite_path = "/root/Main/Player/PlayerSprite/BlasterSprite"
	var blaster_sprite = get_node_or_null(blaster_sprite_path)
	rotation = blaster_sprite.rotation - (PI/2)
	position = blaster_sprite.global_position
	apply_scale(Vector2(2,2))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += Vector2.RIGHT.rotated(rotation) * delta * 400
