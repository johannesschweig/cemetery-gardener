extends Node2D

func _ready() -> void:
	# load bg
	$bg.texture = load("res://assets/scenes/" + GameManager.current_area + ".jpg")
	# create poi buttons
	for poi in GameManager.get_pois_area():
		var b = load("res://assets/scenes/poiButton.tscn").instantiate()
		b.setButton(poi)
		$bg.add_child(b)
	# create submap buttons
	for submap in GameManager.get_submaps_area():
		var b = load("res://assets/scenes/submapButton.tscn").instantiate()
		b.setButton(submap)
		$bg.add_child(b)


func _on_back_to_map_pressed() -> void:
	var map = ""
	if GameManager.current_area == "cellar":
		GameManager.current_area = "chapel"
		get_tree().change_scene_to_file("res://assets/scenes/submap.tscn")
	else:
		GameManager.current_area = "map"
		get_tree().change_scene_to_file("res://assets/scenes/map.tscn")
	
