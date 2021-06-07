extends Node2D

const BACKGROUND_BORDER_THICKNESS := 1
const BACKGROUND_WIDTH := 150
const BACKGROUND_HEIGHT := 35

func update_fuel_level(fuel_level : int):
	var fuel_level_normalized = fuel_level
	if fuel_level > 100:
		fuel_level_normalized = 100
	elif fuel_level < 0:
		fuel_level_normalized = 0
	$ProgressBar.value = fuel_level_normalized

func _draw():
	var background_rect = Rect2(Vector2(0,0), Vector2(BACKGROUND_WIDTH, BACKGROUND_HEIGHT))
	draw_rect(background_rect, Color8(255, 255, 255), true, BACKGROUND_BORDER_THICKNESS)
	draw_rect(background_rect, Color8(0, 0, 0), false, BACKGROUND_BORDER_THICKNESS)
