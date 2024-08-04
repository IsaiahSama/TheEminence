extends Node2D

var miniboss_sprite = preload("res://scenes/miniboss.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_spawner_timeout():
	var miniboss = miniboss_sprite.instantiate()
	get_node(".").add_child(miniboss)
