extends Node2D

@export var stages : Array[PackedScene] = []
@export var maps : Array[PackedScene] = []
var current_stage = 0
var current_map = 0

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

func change_map(map: int):
	current_map = map
	var instance = maps[current_map].instantiate()
	Utils.clear_children(self)
	add_child(instance)
