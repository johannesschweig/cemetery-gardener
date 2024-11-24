extends Node2D

func _ready() -> void:
	var pointer = load("res://assets/pointer.png")
	Input.set_custom_mouse_cursor(pointer, Input.CURSOR_POINTING_HAND )
