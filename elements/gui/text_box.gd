class_name TextBox extends PanelContainer

func show_text_box(title: String, text: String, found_identifier: String = ""):
	%title.text = title
	%description.text = text
	%found.visible = false
	if found_identifier:
		%foundItem.text = Utils.get_title_from_identifier(found_identifier) + " found"
		%foundIcon.texture = load("res://assets/items/" + found_identifier + ".png")
		%found.visible = true
	else:
		%found.visible = false
	self.visible = true

func _on_button_pressed() -> void:
	self.visible = false
