extends Node

# Method for getting random point on map of size max_horizontal x max_verival with some points excluded.
# It can be used to randomly gain a position for the instributor or vegetables that does not overlap with snake`s body.
func rand_point_with_exclusives(max_horizontal:int, max_vertical:int, exclusives:Array):
	randomize()
	var max_index = max_horizontal * max_vertical
	var exclusives_indexes = []
	for exclusive in exclusives:
		var index = exclusive.x + exclusive.y * max_horizontal
		exclusives_indexes.append(index)
	exclusives_indexes.sort()
	var rand_index = randi() % (max_horizontal * max_vertical - exclusives.size())
	for exclusive_index in exclusives_indexes:
		if rand_index < exclusive_index:
			break
		rand_index += 1
	var result_x = rand_index % max_horizontal
	var result_y = rand_index / max_horizontal
	return Vector2(result_x, result_y)

func set_fuel_level(fuel_level : int):
	get_tree().call_group('FuelLevelGroup', 'update_fuel_level', fuel_level)
	
func _ready():
	pass
	
#func _physics_process(delta):
	#get_tree().change_scene("res://score/Score.tscn")
	#get_tree().change_scene("res://train/train_test2D.tscn")
	
