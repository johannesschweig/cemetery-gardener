class_name TextBox extends CenterContainer

func show_text_box(title: String, text: String, found_identifier: String = ""):
	%Title.text = title
	%Description.text = text
	%Found.visible = false
	if found_identifier:
		%FoundItem.text = Utils.get_title_from_identifier(found_identifier) + " found"
		%FoundIcon.texture = load("res://assets/items/" + found_identifier + ".png")
		%Found.visible = true
	else:
		%Found.visible = false
	self.visible = true

func _on_button_pressed() -> void:
	self.visible = false
