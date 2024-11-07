class_name InventoryItem extends PanelContainer

var item

func set_item(i, show: bool) -> void:
	item = i
	$MarginContainer/VBoxContainer/Label.text = GameManager.getTitleFromIdentifier(item.identifier)
	$MarginContainer/VBoxContainer/RichTextLabel.text = item.description
	$MarginContainer/VBoxContainer/icon.texture = load("res://assets/scenes/" + item.icon + ".png")
	# unlock button
	if item.has('unlock'):
		$MarginContainer/VBoxContainer/HBoxContainer/unlock.visible = true
	$".".visible = show

func _on_info_pressed() -> void:
	GameManager.click_button(item.identifier)

func _on_unlock_pressed() -> void:
	GameManager.click_unlock(item.identifier, item.solution)
