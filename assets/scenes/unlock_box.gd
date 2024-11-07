class_name UnlockBox extends PanelContainer

var solution
var identifier

func setUnlockBox(id: String, code: String):
	identifier = id
	solution = code
	var title = GameManager.getTitleFromIdentifier(identifier)
	$VBoxContainer/HBoxContainer/title.text = title
	$VBoxContainer/description.text = "Enter the code to unlock \"" + title + "\":"
	self.visible = true

func _on_close_pressed() -> void:
	self.visible = false
	$VBoxContainer/feedback.visible = false
	$VBoxContainer/input.text = ''

func _on_unlock_pressed() -> void:
	if $VBoxContainer/input.text == solution:
		$VBoxContainer/feedback.text = "This code is right."
		GameManager.click_button(identifier + "_unlocked")
	else:
		$VBoxContainer/feedback.text = "This code is wrong."
	$VBoxContainer/feedback.visible = true
