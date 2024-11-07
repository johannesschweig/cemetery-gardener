extends PanelContainer

func _ready() -> void:
	if GameManager.debug: # show all items
			$VBoxContainer/MarginContainer.visible = true
			$VBoxContainer/Label.visible = false
			var icons = $VBoxContainer/MarginContainer/PanelContainer.get_children()
			for i in range(icons.size()):
				icons[i].set_item(GameManager.inventory[i], true)
	else:
		if GameManager.getNumberOfFoundItems() == 0:
			$VBoxContainer/MarginContainer.visible = false
			$VBoxContainer/Label.visible = true
		else:
			$VBoxContainer/MarginContainer.visible = true
			$VBoxContainer/Label.visible = false
			var icons = $VBoxContainer/MarginContainer/PanelContainer.get_children()
			for i in range(icons.size()):
				icons[i].set_item(GameManager.inventory[i], GameManager.inventory[i].status != 0)

func _on_button_pressed() -> void:
	if GameManager.current_area == 'map':
		get_tree().change_scene_to_file("res://assets/scenes/map.tscn")
	else:
		get_tree().change_scene_to_file("res://assets/scenes/submap.tscn")
