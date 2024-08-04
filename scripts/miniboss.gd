extends Node2D


# Called when the node enters the scene tree for the first time.
var rng = RandomNumberGenerator.new()

func _ready():
	get_node("Body").self_modulate = Color8(rng.randi_range(0, 255),rng.randi_range(0, 255), rng.randi_range(0, 255))
	position = Vector2(rng.randf_range(100, 200), rng.randf_range(100, 200))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
