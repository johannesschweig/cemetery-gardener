extends TileMapLayer

var name_label

func _ready() -> void:
	name_label = Label.new()

func _process(_delta):
	var mouse_pos_global = get_viewport().get_mouse_position()
	var mouse_pos_local = to_local(mouse_pos_global)
	var tile_pos = local_to_map(mouse_pos_local)
	var tile_data = get_cell_tile_data(tile_pos)
	if tile_data is TileData:
		var name = tile_data.get_custom_data("name")
		print(name, tile_pos, map_to_local(tile_pos))
		name_label.text = name
		name_label.position = map_to_local(tile_pos)
		
		add_child(name_label)
	else:
		if self.get_children():
			self.remove_child(name_label)
