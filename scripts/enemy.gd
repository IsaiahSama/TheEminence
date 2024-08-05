extends Node2D

@onready var player = get_node("/root/UltraMain/Player")
var bullet = preload("res://scenes/enemybullet.tscn")
var type = 0
var speed = 0
var damage = 0
var health = 0
var knockback = 0
var animArray = ["base","tank","energy","base_damage","tank_damage","energy_damage","base_death","tank_death","energy_death"]
var player_in_contact = false

enum {BASE_ENEMY, TANK_ENEMY, ENERGY_ENEMY}

var locations = [Vector2(540, 20), Vector2(0, 318), Vector2(1120, 318), Vector2(540, 626)]

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D.area_entered.connect(_on_area_2d_area_entered)
	$Area2D.area_exited.connect(_on_area_2d_area_exited)
	position = locations[rng.randi_range(0, len(locations) - 1)]
	var typeGen = 0.9 #randf_range(0,1)
=======
	var typeGen = randf_range(0,1)
>>>>>>> c7d6c91cd4b81bb16cfb5d11d859650a18c74ec0
	
	if 0 <= typeGen && typeGen < 0.7:
		type = BASE_ENEMY
		speed = 125
		damage = 1
		health = 3
		knockback = 1
	elif 0.7 <= typeGen && typeGen < 0.9:
		type = TANK_ENEMY
		speed = 60
		damage = 2
		health = 4
		knockback = 2
	else:
		type = ENERGY_ENEMY
		speed = 125
		damage = 1
		health = 2
		knockback = 1
	$Sprite.play(animArray[type])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not player.dead:
		if player_in_contact:
			var direction = (player.position - global_position).normalized()
			player.hurt(damage,knockback,direction.angle())
			
		if health <= 0:
			$Sprite.play(animArray[type+6])
			await $Sprite.animation_finished
			queue_free()
		else:
			var direction = player.position - position
			
			direction = direction.normalized()
			position += direction * speed * delta
			
		if type == ENERGY_ENEMY:
			if Input.is_action_just_pressed("leftClick"):
				var instance = bullet.instantiate()
				add_child(instance)
	else:
		$Sprite.stop()
	
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
	health -= player.power
	$Sprite.play(animArray[type+3])
	await $Sprite.animation_finished
	$Sprite.play(animArray[type])
