extends CanvasLayer

func _ready():
	$Start.play()
	
func _on_StartButton_pressed():
	get_tree().change_scene("res://MainGame.tscn")
