extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	rotation = get_node("../Player").rotation
	position = get_node("../Player").position
	visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += Vector2.RIGHT.rotated(rotation) * delta * 400
