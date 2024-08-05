extends Node2D
var speed = 0
var damage = 0
var health = 0

# Called when the node enters the scene tree for the first time.
var rng = RandomNumberGenerator.new()
@onready var player = get_node("/root/UltraMain/Player")
var player_in_contact = false

func _ready():
	get_node("Body").self_modulate = Color8(rng.randi_range(0, 255),rng.randi_range(0, 255), rng.randi_range(0, 255))

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

func cloneSystem(delta):
	# Table of Options and Build Values 
	var Hlow: int = 5
	var Hmed: int = 10
	var Hhigh: int = 15

	var Rlow: int = 5
	var Rmed: int = 10
	var Rhigh: int = 15

	var Plow: int = 5
	var Pmed: int = 10
	var Phigh: int = 15

	var HSelect = 0
	var RSelect = 0
	var PSelect = 0

	# Health 
	var HealthTable: Array = [Hlow, Hmed, Hhigh]

	# Range 
	var RangeTable: Array = [Rlow, Rmed, Rhigh]

	#Power
	var PowerTable: Array = [Plow, Pmed, Phigh]

	# Generate Color to add to A and B based off HSV system
	# Color.pickRandom(0-1, 0-1, 0-1, 0-1) 

	#Make two Clones with stats 
	var BuildA: Array = [HealthTable.pick_random(), RangeTable.pick_random(), PowerTable.pick_random()]
	var BuildB: Array = [HealthTable.pick_random(), RangeTable.pick_random(), PowerTable.pick_random() ]

	# The Selected Player Stats
	var BuildSelect: Array = [HSelect,RSelect,PSelect]

	#Test Array Works 
	print(BuildA[0] + "," + BuildA[1] + "," + BuildA[2]) 
	print(BuildB[0] + "," + BuildB[1] + "," + BuildB[2]) 
	print(BuildSelect[0] + "," + BuildSelect[1] + "," + BuildSelect[2]) 

	#Check if A = B if so reroll 
	##if BuildA[0] == BuildB[0]
	var ReplacementBuild: Array = [HealthTable.pick_random(), RangeTable.pick_random(), PowerTable.pick_random()]
	var Unselected: Array = []

	#Add Unselected to Arraylist and check agaisnt A and B
	var RemovedCombo: Array = [Unselected]
