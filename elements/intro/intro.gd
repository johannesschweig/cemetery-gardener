extends Node2D


func _on_continue_pressed() -> void:
	get_parent().next_stage()


func _on_english_pressed() -> void:
	TranslationServer.set_locale("en")


func _on_german_pressed() -> void:
	TranslationServer.set_locale("de")
