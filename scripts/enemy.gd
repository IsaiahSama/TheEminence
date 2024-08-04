extends Node2D

var type = 0
var speed = 0
var damage = 0
var health = 0
var animArray = ["base","tank","energy","base_damage","tank_damage","energy_damage"]

# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D.area_entered.connect(_on_area_2d_area_entered)
	var typeGen = 0.0 #randf_range(0,1)
	
	if 0 <= typeGen && typeGen < 0.7:
		type = 0
		speed = 50
		damage = 1
		health = 3
	elif 0.7 <= typeGen && typeGen < 0.9:
		type = 1
		speed = 25
		damage = 2
		health = 4
	else:
		type = 2
		speed = 50
		damage = 1
		health = 2
	$Sprite.play(animArray[type])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if health < 0:
		print("DEAD")
	
func _on_area_2d_area_entered(area):
	hurt()

func hurt():
	health -= 1
	$Sprite.play(animArray[type+3])
	await $Sprite.animation_finished
	$Sprite.play(animArray[type])
