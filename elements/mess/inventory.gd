extends PanelContainer

func _ready() -> void:
	if GameManager.debug: # show all items
			%items.visible = true
			%emptyState.visible = false
			var icons = %itemsContainer.get_children()
			for i in range(icons.size()):
				icons[i].set_item(GameManager.inventory[i], true)
	else:
		if GameManager.getNumberOfFoundItems() == 0:
			%items.visible = false
			%emptyState.visible = true
		else:
			%items.visible = true
			%emptyState.visible = false
			var icons = %itemsContainer.get_children()
			for i in range(icons.size()):
				icons[i].set_item(GameManager.inventory[i], GameManager.inventory[i].status != 0)

func _on_button_pressed() -> void:
	if GameManager.current_area == 'map':
		get_tree().change_scene_to_file("res://elements/mess/map.tscn")
	else:
		get_tree().change_scene_to_file("res://elements/mess/submap.tscn")
