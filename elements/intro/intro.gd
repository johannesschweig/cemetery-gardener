extends Node2D


func _on_continue_pressed() -> void:
	get_parent().next_stage()