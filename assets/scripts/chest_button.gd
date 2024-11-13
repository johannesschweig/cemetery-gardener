extends Button

func _ready() -> void:
	GameManager.chest_found.connect(_on_chest_found)
	%Label.text = '26'

func _on_pressed() -> void:
	GameManager.click_button("chest")

func _on_chest_found() -> void:
	# This will run when the signal is emitted from GameManager
	self.visible = true
