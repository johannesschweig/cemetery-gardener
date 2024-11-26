extends Node2D

enum ItemStatus {
	INITIAL,
	FOUND,
	USED
}

# turn identifiers into human readable titles
func get_title_from_identifier(identifier: String):
	return identifier.replace("_", " ").capitalize()

# removes all children from a node
func clear_children(node: Node):
	for c in node.get_children():
		node.remove_child(c)
		c.queue_free()
