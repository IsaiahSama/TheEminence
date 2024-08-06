extends CanvasLayer

var heart_sprite = preload("res://scenes/UI/heart.tscn")
var stat_texture_node = preload("res://scenes/UI/stat_texture.tscn")

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
		
func set_stats(max_health, range, power):
	var life_texture = $"StatUI/LifeTexture"
	var range_texture = $"StatUI/RangeTexture"
	var pow_texture = $"StatUI/PowTexture"
	
	life_texture.size = Vector2(16 * (max_health - 2), 16)
	range_texture.size = Vector2(16 * range, 16)
	pow_texture.size = Vector2(16 * power, 16)

