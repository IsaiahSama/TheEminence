extends AnimatedSprite2D

@onready var player = get_node("Player")

# Called when the node enters the scene tree for the first time.
func _ready():
	frame_changed.connect(_on_frame_changed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player.dead: visible = false

func _on_frame_changed():
	if frame == sprite_frames.get_frame_count("default") - 1:
		stop()
