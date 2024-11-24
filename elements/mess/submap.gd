extends Node2D

func _ready() -> void:
	# load bg
	%bg.texture = load("res://elements/mess/" + GameManager.current_area + ".jpg")
	# create poi buttons
	for poi in GameManager.get_pois_area():
		var b = load("res://elements/mess/poiButton.tscn").instantiate()
		b.setButton(poi)
		%bg.add_child(b)
	# create submap buttons
	for submap in GameManager.get_submaps_area():
		var b = load("res://elements/mess/submapButton.tscn").instantiate()
		b.setButton(submap)
		%bg.add_child(b)


func _on_back_to_map_pressed() -> void:
	get_parent().change_map(0)
	
