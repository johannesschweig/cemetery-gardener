class_name TextBox extends PanelContainer

func setTextBox(title: String, text: String, foundIdentifier: String, foundIcon: String):
	%title.text = title
	%description.text = text
	%found.visible = false
	if foundIdentifier:
		%foundItem.text = foundIdentifier + " found"
		%foundIcon.texture = load("res://assets/scenes/" + foundIcon + ".png")
		%found.visible = true
	self.visible = true

func _on_button_pressed() -> void:
	self.visible = false
