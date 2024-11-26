class_name InventoryItem extends PanelContainer

var item

func set_item(i) -> void:
	item = i
	%name.text = Utils.get_title_from_identifier(item.identifier)
	%description.text = item.description
	%icon.texture = load("res://assets/items/" + item.identifier + ".png")
	# unlock button
	if item.has('unlock'):
		%unlock.visible = true
	self.visible = true

func _on_info_pressed() -> void:
	pass#GameManager.click_button(item.identifier)

func _on_unlock_pressed() -> void:
	pass#GameManager.click_unlock(item.identifier, item.solution)
