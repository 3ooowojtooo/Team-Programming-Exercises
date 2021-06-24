extends Node

const BOARD_SIZE = 1000
const CELL_SIZE = 100
var cell_number = (BOARD_SIZE/CELL_SIZE) - 1
var vegetable_position
var vegetable_number

var game = load("res://MainGame.gd").new()
var point = Vector2(0,0)
var array = [point]

func _ready():
	print(game.rand_point_with_exclusives(10,10, array))
	vegetable_position = position_vegetable()
	vegetable_number = get_next_vegetable()
	draw_vegetable()

func position_vegetable():
	randomize()
	var p_x = randi() % cell_number
	var p_y = randi() % cell_number
	return Vector2(p_x, p_y)

func get_next_vegetable():
	randomize()
	var number = randi() % 5
	return number

func draw_vegetable():
	$Vegetables.set_cell(vegetable_position.x, vegetable_position.y, vegetable_number)


