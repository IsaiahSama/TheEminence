extends Node2D

var enemy = preload("res://scenes/enemy.tscn")
var miniboss = preload("res://scenes/miniboss.tscn")

@onready var player = $Player

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_enemy_spawn_timeout():
	var instance = enemy.instantiate()
	get_node(".").add_child(instance)

func _on_miniboss_slain(miniboss):
	$"Minibosses".remove_child(miniboss)
	miniboss.queue_free()
	
	var target = $"Minibosses".get_child(0)
	
	print("Surviving Miniboss's stats: ", target.stats)
	player.ascend(target.stats)
	target.queue_free()
	

func _on_miniboss_timer_timeout():
	var miniboss1 = miniboss.instantiate()
	var miniboss2 = miniboss.instantiate()
	
	miniboss1.position = Vector2(0, 318)
	miniboss2.position = Vector2(1120, 318)
	
	var builds = cloneSystem()
	var buildA = builds[0]
	var buildB = builds[1]
	
	miniboss1.set_stats(buildA)
	miniboss2.set_stats(buildB)
	
	miniboss1.miniboss_slain.connect(_on_miniboss_slain)
	miniboss2.miniboss_slain.connect(_on_miniboss_slain)
	
	$"Minibosses".add_child(miniboss1)
	$"Minibosses".add_child(miniboss2)

func cloneSystem():
	# Table of Options and Build Values 
	var Hlow: int = 3
	var Hmed: int = 4
	var Hhigh: int = 5	

	var Rlow: int = 1
	var Rmed: int = 2
	var Rhigh: int = 3

	var Plow: int = 1
	var Pmed: int = 2
	var Phigh: int = 3

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

	#Check if A = B if so reroll 
	##if BuildA[0] == BuildB[0]
	var ReplacementBuild: Array = [HealthTable.pick_random(), RangeTable.pick_random(), PowerTable.pick_random()]
	var Unselected: Array = []

	#Add Unselected to Arraylist and check agaisnt A and B
	var RemovedCombo: Array = [Unselected]
	
	return [BuildA, BuildB]
