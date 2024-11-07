class_name TextBox extends PanelContainer

func setTextBox(title: String, text: String, foundIdentifier: String, foundIcon: String):
	$VBoxContainer/HBoxContainer/title.text = title
	$VBoxContainer/RichTextLabel.text = text
	$VBoxContainer/found.visible = false
	if foundIdentifier:
		$VBoxContainer/found/foundItem.text = foundIdentifier + " found"
		$VBoxContainer/found/icon.texture = load("res://assets/scenes/" + foundIcon + ".png")
		$VBoxContainer/found.visible = true
	self.visible = true

func _on_button_pressed() -> void:
	self.visible = false
