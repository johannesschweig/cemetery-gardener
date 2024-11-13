extends Node2D

@export var stages : Array[PackedScene] = []

func _ready() -> void:
	if len(stages) > 0:
		var instance = stages[0].instantiate()
		add_child(instance)

# TODO incorporate debug flag
