class_name UnlockBox extends PanelContainer

var solution
var identifier

func setUnlockBox(id: String, code: String):
	identifier = id
	solution = code
	var title = GameManager.getTitleFromIdentifier(identifier)
	var placeholder = ''
	$VBoxContainer/HBoxContainer/title.text = title
	$VBoxContainer/description.text = "Enter the code to unlock \"" + title + "\":"
	$VBoxContainer/input.max_length = len(solution)
	for i in range(len(solution)):
		placeholder += '•'
	$VBoxContainer/input.placeholder_text = placeholder
	self.visible = true

func _on_close_pressed() -> void:
	self.visible = false
	$VBoxContainer/feedback.visible = false
	$VBoxContainer/input.text = ''

func _on_unlock_pressed() -> void:
	var clue = $VBoxContainer/input.text
	if clue == solution:
		$VBoxContainer/feedback.text = "This code is right."
		GameManager.click_button(identifier + "_unlocked")
	else:
		if len(clue) < len(solution):
			$VBoxContainer/feedback.text = "This code is wrong. " + str(len(solution)) + " characters required."
		else:
			$VBoxContainer/feedback.text = "This code is wrong."
	$VBoxContainer/feedback.visible = true
