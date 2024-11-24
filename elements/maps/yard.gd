extends Node2D

func _ready() -> void:
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
