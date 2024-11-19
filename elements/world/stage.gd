extends Node2D

@export var stages : Array[PackedScene] = []
var current_stage = 0

func _ready() -> void:
	if len(stages) > 0:
		var instance = stages[0].instantiate()
		add_child(instance)

func next_stage():
	current_stage += 1
	var instance = stages[current_stage].instantiate()
	for c in self.get_children():
		self.remove_child(c)
		c.queue_free()
	add_child(instance)
# TODO incorporate debug flag
