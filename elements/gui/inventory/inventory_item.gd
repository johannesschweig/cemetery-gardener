class_name InventoryItem extends PanelContainer

var item

func set_item(i) -> void:
	item = i
	%name.text = Utils.get_title_from_identifier(item.identifier)
	# translate string if it is a constant
	%description.text = item.description if item.description[0] == item.description[0].to_lower() else tr(item.description)
	%icon.texture = load("res://assets/items/" + item.identifier + ".png")
	# unlock button
	if item.has('unlock'):
		%unlock.visible = true
	else:
		%unlock.hide()
	self.visible = true

func _on_info_pressed() -> void:
	get_node("/root/World/Gui").click_poi_or_item(item.identifier)

func _on_unlock_pressed() -> void:
	get_node("/root/World/Gui").show_unlock_box(item.identifier, item.solution)
