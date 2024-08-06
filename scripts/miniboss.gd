extends Node2D
var speed = 80
var damage: int
var range: int
var health: int 
var stats: Array

signal miniboss_slain

# Called when the node enters the scene tree for the first time.
var rng = RandomNumberGenerator.new()
@onready var player = get_node("/root/UltraMain/Player")
var player_in_contact = false

func _ready():
	get_node("Body").self_modulate = Color8(rng.randi_range(0, 255),rng.randi_range(0, 255), rng.randi_range(0, 255))

func set_stats(stats_array):
	stats = stats_array
	health = stats[0]
	range = stats[1]
	damage = stats[2]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not player.dead:
		if player_in_contact:
			var direction = (player.position - global_position).normalized()
			player.hurt(1,1,direction.angle())
			
		if health <= 0:
			queue_free()
		else:
			var direction = player.position - position
			
			direction = direction.normalized()
			position += direction * speed * delta
			
func _on_area_2d_area_entered(area):
	if not player.dead:
		if area.collision_layer == 2:
			hurt()
		if area.collision_layer == 1:
			player_in_contact = true
			
func _on_area_2d_area_exited(area):
	if not player.dead:
		player_in_contact = false
			
func hurt():
	health -= 1
	if health <= 0:
		miniboss_slain.emit(self)
