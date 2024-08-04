#extends Node


# Called when the node enters the scene tree for the first time.
#func _ready():
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass

extends Node
func _ready():
	pass

func _cloneSystem(delta):
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

	#Iterated through Removed Combo and check
	#for(i = 0; i< RemovedCombo.size();i++)
		#if (RemovedCombo[i] == BuildA || RemovedCombo[i] == BuildB)
			#var ReplacmentBuild: Array = [HealthTable.pick_random(), RangeTable.pick_random(), PowerTable.pick_random()]
			#break
