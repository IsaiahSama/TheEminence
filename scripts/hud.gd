extends CanvasLayer

var heart_sprite = preload("res://scenes/heart.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_life(max_health: int):
	var hearts = $"Hearts"
	
	var x = 0
	var y = 0
	
	for heart in hearts.get_children():
		hearts.remove_child(heart)
		heart.queue_free()
	
	for hp in max_health:
		var heart = heart_sprite.instantiate();
		heart.position = Vector2(x, y)
		x += 32
		hearts.add_child(heart)

func update_life(health):
	var hearts = $"Hearts".get_children()
	
	for i in range(health):
		hearts[i].get_node("heart").play("Alive")
	
	for i in range(health, hearts.size()):
		hearts[i].get_node("heart").play("Dead")

