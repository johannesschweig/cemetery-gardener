class_name TextBox extends PanelContainer

func setTextBox(title: String, text: String):
	$VBoxContainer/HBoxContainer/title.text = title
	$VBoxContainer/RichTextLabel.text = text
	self.visible = true

func _on_button_pressed() -> void:
	self.visible = false
