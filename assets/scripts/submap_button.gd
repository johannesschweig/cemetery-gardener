class_name SubmapButton extends Button

var identifier

func setButton(submap):
	identifier = submap.identifier
	self.position = Vector2(submap.x, submap.y)
	self.set_custom_minimum_size(Vector2(submap.width, submap.height))

func _on_pressed() -> void:
	GameManager.current_area = identifier
	get_tree().change_scene_to_file("res://assets/scenes/submap.tscn")
