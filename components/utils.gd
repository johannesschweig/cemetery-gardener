extends Node2D

# turn identifiers into human readable titles
func get_title_from_identifier(identifier: String):
	return identifier.replace("_", " ").capitalize()
