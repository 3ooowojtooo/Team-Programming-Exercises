extends Node2D

const BACKGROUND_BORDER_THICKNESS := 1

func update_score(score : int):
	$Label.text = str(score)

func _draw():
	var background_rect_position = Vector2($Label.rect_position.x + BACKGROUND_BORDER_THICKNESS, $Apple.position.y - $Apple.texture.get_size().y / 2)
	var background_rect_height = $Apple.texture.get_size().y
	var background_rect_width = $Apple.position.x + $Apple.texture.get_size().x / 2
	var background_rect_size = Vector2(background_rect_width, background_rect_height)
	var background_rect = Rect2(background_rect_position, background_rect_size)
	draw_rect(background_rect, Color8(255, 255, 255), true, BACKGROUND_BORDER_THICKNESS)
	draw_rect(background_rect, Color8(0, 0, 0), false, BACKGROUND_BORDER_THICKNESS)
