extends Node2D

var enemy = preload("res://scenes/enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_enemy_spawn_timeout():
	var instance = enemy.instantiate()
	get_node(".").add_child(instance)


func _on_miniboss_timer_timeout():
	pass # Replace with function body.
