extends Node2D

const BOARD_SIZE = 1000
const CELL_SIZE = 100
const TRAIN = 0
var cell_number = (BOARD_SIZE/CELL_SIZE) - 1
var train_body = [Vector2(2, 0), Vector2(1, 0), Vector2(0, 0)]
var train_direction = Vector2(1, 0)
var add_vegatable = false

#vegetbale to be delete - for train logic testing
###################################################
const BANANA = 1
var banana_pos
###################################################

func _ready():
	banana_pos = place_banana()
	
func draw_train():
	for segment_index in train_body.size():
		var segment = train_body[segment_index]
		if segment_index == 0:
			var train_head_dir = relation2(train_body[0], train_body[1])
			if train_head_dir == 'right':
				$train.set_cell(segment.x, segment.y, TRAIN, false, false, false, Vector2(0, 0))
			if train_head_dir == 'left':
				$train.set_cell(segment.x, segment.y, TRAIN, false, false, false, Vector2(0, 1))
			if train_head_dir == 'bottom':
				$train.set_cell(segment.x, segment.y, TRAIN, false, true, false, Vector2(1, 0))
			if train_head_dir == 'top':
				$train.set_cell(segment.x, segment.y, TRAIN, false, true, false, Vector2(1, 1))
		elif segment_index == train_body.size() - 1: 
			var train_tail_dir = relation2(train_body[-1], train_body[-2])
			if train_tail_dir == 'right':
				$train.set_cell(segment.x, segment.y, TRAIN, false, false, false, Vector2(0, 0))
			if train_tail_dir == 'left':
				$train.set_cell(segment.x, segment.y, TRAIN, false, false, false, Vector2(0, 1))
			if train_tail_dir == 'bottom':
				$train.set_cell(segment.x, segment.y, TRAIN, false, true, false, Vector2(1, 0))
			if train_tail_dir == 'top':
				$train.set_cell(segment.x, segment.y, TRAIN, false, true, false, Vector2(1, 1))
		else:
			var previous_segment = train_body[segment_index + 1] - segment
			var next_segment = train_body[segment_index - 1] - segment
			if previous_segment.x == next_segment.x:
				$train.set_cell(segment.x, segment.y, TRAIN, false, false, false, Vector2(2, 1))
			elif previous_segment.y == next_segment.y:
				$train.set_cell(segment.x, segment.y, TRAIN, false, false, false, Vector2(2, 0))
			else:
				if previous_segment.x == -1 and next_segment.y == -1 or next_segment.x == -1 and previous_segment.y == -1:
					$train.set_cell(segment.x, segment.y, TRAIN, false, false, false, Vector2(4, 1))
				if previous_segment.x == -1 and next_segment.y == 1 or next_segment.x == -1 and previous_segment.y == 1:
					$train.set_cell(segment.x, segment.y, TRAIN, false, false, false, Vector2(4, 0))
				if previous_segment.x == 1 and next_segment.y == -1 or next_segment.x == 1 and previous_segment.y == -1:
					$train.set_cell(segment.x, segment.y, TRAIN, false, false, false, Vector2(3, 1))
				if previous_segment.x == 1 and next_segment.y == 1 or next_segment.x == 1 and previous_segment.y == 1:
					$train.set_cell(segment.x, segment.y, TRAIN, false, false, false, Vector2(3, 0))
					
				
func relation2(first_segment:Vector2, second_segment:Vector2):
	var segment_relation = second_segment - first_segment
	if segment_relation == Vector2(-1, 0): return 'right'
	if segment_relation == Vector2(1, 0): return 'left'
	if segment_relation == Vector2(0, 1): return 'bottom'
	if segment_relation == Vector2(0, -1): return 'top'
	
func move_train():
	if add_vegatable:
		set_score_label(train_body.size() - 3)
		delete_tiles(TRAIN)
		var train_copy = train_body.slice(0, train_body.size() - 1)
		var new_head = train_copy[0] + train_direction
		train_copy.insert(0, new_head)
		train_body = train_copy
		add_vegatable = false
	else:
		delete_tiles(TRAIN)
		var train_copy = train_body.slice(0, train_body.size() - 2)
		var new_head = train_copy[0] + train_direction
		train_copy.insert(0, new_head)
		train_body = train_copy

func delete_tiles(id:int):
	var cells = $train.get_used_cells_by_id(id)
	for cell in cells:
		$train.set_cell(cell.x, cell.y, -1)

func check_vegetable():
	if banana_pos == train_body[0]:
		banana_pos = place_banana()
		add_vegatable = true
				
func check_game_over():
	var train_head = train_body[0]
	# train leaves the screen
	if train_head.x > cell_number or train_head.x < 0 or train_head.y < 0 or train_head.y > cell_number:
		reset()
		get_tree().change_scene("res://board/game_over_board/GameOverScreen.tscn")
	# train crash
	for segment in train_body.slice(1, train_body.size() - 1):
		if segment == train_head:
			reset()
			get_tree().change_scene("res://board/game_over_board/GameOverScreen.tscn")
	
func reset():
	train_body = [Vector2(2, 0), Vector2(1, 0), Vector2(0, 0)]
	train_direction = Vector2(1, 0)
	
func _input(event):
	if Input.is_action_just_pressed("ui_up"):    
		if not train_direction == Vector2(0, 1):
			train_direction = Vector2(0, -1)
	if Input.is_action_just_pressed("ui_right"): 
		if not train_direction == Vector2(-1, 0):
			train_direction = Vector2(1, 0)
	if Input.is_action_just_pressed("ui_left"):  
		if not train_direction == Vector2(1, 0):
			train_direction = Vector2(-1, 0) 
	if Input.is_action_just_pressed("ui_down"):  
		if not train_direction == Vector2(0, -1):
			train_direction = Vector2(0, 1)
		
func _on_trainTick_timeout():
	move_train()
	draw_train()
	draw_banana()
	check_vegetable()

func _process(delta):
	check_game_over()
	
	
# Method for updating score label to display new score value
func set_score_label(score : int):
	get_tree().call_group('ScoreGroup', 'update_score', score)
		

#vegetbale to be delete - for train logic testing
###################################################
func place_banana():
	randomize()
	var x = randi() % cell_number
	var y = randi() % cell_number
	return Vector2(x, y)
	
func draw_banana():
	$train.set_cell(banana_pos.x, banana_pos.y, BANANA)
###################################################
