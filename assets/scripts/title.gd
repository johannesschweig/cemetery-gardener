extends Sprite2D

var stage = 0 # 0: intro, 1: intro-1, 2: intro-2

func _on_continue_pressed() -> void:
	if stage == 0:
		stage = 1
		$".".texture = load("res://assets/scenes/intro-1.jpg")
	elif stage == 1:
		stage = 2
		$".".texture = load("res://assets/scenes/intro-2.jpg")
	else:
		get_tree().change_scene_to_file("res://assets/scenes/map.tscn")
