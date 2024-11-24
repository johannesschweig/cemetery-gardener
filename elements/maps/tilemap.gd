extends TileMapLayer

var cursor = load("res://assets/cursor.png")
var pointer = load("res://assets/pointer.png")

func _process(_delta):
	var mouse_pos_global = get_viewport().get_mouse_position()
	var tile_pos = local_to_map(mouse_pos_global)
	var tile_data = get_cell_tile_data(tile_pos)
	if tile_data is TileData:
		var name = GameManager.getTitleFromIdentifier(tile_data.get_custom_data("name"))
		if !self.get_children() and name:
			var position = map_to_local(tile_pos) - Vector2((len(name) * 17) / 2, 20)
			get_node('/root/World/Gui').showPoiLabelPanel(name, position)
			# change cursor
			Input.set_custom_mouse_cursor(pointer)
	else:
		Input.set_custom_mouse_cursor(cursor)
		get_node('/root/World/Gui').hidePoiLabelPanel()
