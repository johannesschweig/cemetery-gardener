extends CenterContainer

var solution
var identifier

func show_unlock_box(id: String, code: String):
	identifier = id
	solution = code
	var title = Utils.get_title_from_identifier(identifier)
	var placeholder = ''
	%title.text = title
	%description.text = "Enter the code to unlock \"" + title + "\":"
	%input.max_length = len(solution)
	for i in range(len(solution)):
		placeholder += '•'
	%input.placeholder_text = placeholder
	self.visible = true

func _on_close_pressed() -> void:
	self.visible = false
	%feedback.visible = false
	%input.text = ''

func _on_unlock_pressed() -> void:
	var clue = %input.text
	if clue == solution:
		%feedback.text = "This code is right."
		get_node("/root/World/Gui").click_poi_or_item(identifier + "_unlocked")
	else:
		if len(clue) < len(solution):
			%feedback.text = "This code is wrong. " + str(len(solution)) + " characters required."
		else:
			%feedback.text = "This code is wrong."
	%feedback.visible = true
