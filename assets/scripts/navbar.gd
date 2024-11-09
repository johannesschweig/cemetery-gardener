extends Control

func getLabelText() -> String:
	var foundItems = GameManager.getNumberOfFoundItems()
	if foundItems == 0:
		return "Open Inventory (Empty)"
	else:
		return "Open Inventory (%s)" % foundItems

func _ready() -> void:
	GameManager.item_found.connect(_on_item_found)
	$Button.text = getLabelText()

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://assets/scenes/inventory.tscn")

func _on_item_found() -> void:
	$Button.text = getLabelText()
