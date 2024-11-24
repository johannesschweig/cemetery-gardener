class_name SubmapButton extends Button

var identifier

func setButton(submap):
	identifier = submap.identifier
	self.position = Vector2(submap.x, submap.y)
	self.set_custom_minimum_size(Vector2(submap.width, submap.height))

func _on_pressed() -> void:
	GameManager.current_area = identifier
	get_parent().get_parent().get_parent().change_map(1)
