extends Node2D

enum ItemStatus {
	INITIAL,
	FOUND,
	USED
}

# turn identifiers into human readable titles
func get_title_from_identifier(identifier: String):
	return identifier.replace("_", " ").capitalize()
