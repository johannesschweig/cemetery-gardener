class_name POIButton extends Control

var identifier

func setButton(poi):
	identifier = poi.identifier
	self.position = Vector2(poi.x, poi.y)
	self.set_custom_minimum_size(Vector2(poi.width, poi.height))

func _on_button_pressed() -> void:
	GameManager.click_button(identifier)
