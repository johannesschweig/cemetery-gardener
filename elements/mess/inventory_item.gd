class_name InventoryItem extends PanelContainer

var item

func set_item(i, show: bool) -> void:
	item = i
	%name.text = GameManager.getTitleFromIdentifier(item.identifier)
	%description.text = item.description
	%icon.texture = load("res://assets/scenes/" + item.icon + ".png")
	# unlock button
	if item.has('unlock'):
		%unlock.visible = true
	self.visible = show

func _on_info_pressed() -> void:
	GameManager.click_button(item.identifier)

func _on_unlock_pressed() -> void:
	GameManager.click_unlock(item.identifier, item.solution)
