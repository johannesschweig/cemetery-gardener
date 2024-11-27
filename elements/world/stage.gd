extends Node2D

@export var stages : Array[PackedScene] = []
var current_stage = 0
var current_map = "yard"

func _ready() -> void:
	if len(stages) > 0:
		var instance = stages[0].instantiate()
		add_child(instance)

func next_stage():
	current_stage += 1
	var instance = stages[current_stage].instantiate()
	Utils.clear_children(self)
	add_child(instance)
	if current_stage == 3:
		get_node("/root/World/Gui").visible = true
	else:
		get_node("/root/World/Gui").visible = false
# TODO incorporate debug flag

func change_map(map: String):
	current_map = map
	print(map)
	var map_scene = load("res://elements/maps/" + map + ".tscn")
	var instance = map_scene.instantiate()
	Utils.clear_children(self)
	add_child(instance)
	# hide or show back map
	get_node("/root/World/Gui").toggle_back_map(show_back_map())

func back_map():
	match(current_map):
		"house": change_map("yard")
		"chapel": change_map("yard")
		"crematorium": change_map("chapel")

func show_back_map():
	match(current_map):
		"house": return true
		"chapel": return true
		"crematorium": return true
		_: return false
