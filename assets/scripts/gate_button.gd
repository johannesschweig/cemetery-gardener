extends Button

func _ready() -> void:
	if GameManager.current_area == 'chapel':
		$".".visible = true
		GameManager.crematorium_key_found.connect(_on_crematorium_key_found)
		## Change image if replacement key used
		if GameManager.status(22) == 2:
			$Sprite2D.texture = load("res://assets/scenes/gateOpen.png")
			$Label.text = '40'

func _on_pressed() -> void:
	# if no key -> text
	# if key -> text
	if GameManager.status(22) != 2:
		GameManager.click_button("gate")
	else: # if key used -> move to other scene
		GameManager.current_area = 'cellar'
		get_tree().change_scene_to_file("res://assets/scenes/submap.tscn")

func _on_crematorium_key_found() -> void:
	# This will run when the signal is emitted from GameManager
	$Sprite2D.texture = load("res://assets/scenes/gateOpen.png")
	$Label.text = '40'
