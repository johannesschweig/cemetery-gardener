extends TileMapLayer

var cursor = load("res://assets/cursor.png")
var pointer = load("res://assets/pointer.png")

# on hover: change cursor and show label
func _process(_delta):
	var mouse_pos_global = get_viewport().get_mouse_position()
	var tile_pos = local_to_map(mouse_pos_global)
	var tile_data = get_cell_tile_data(tile_pos)
	if tile_data is TileData:
		var name = Utils.get_title_from_identifier(tile_data.get_custom_data("name"))
		var hidden = tile_data.get_custom_data("hidden")
		# change cursor and show poi label if hovering
		if !self.get_children() and name and !hidden:
			var position = map_to_local(tile_pos) - Vector2((len(name) * 17) / 2, 20)
			get_node('/root/World/Gui').show_poi_label_panel(name, position)
			# change cursor
			Input.set_custom_mouse_cursor(pointer)
		
	else:
		Input.set_custom_mouse_cursor(cursor)
		get_node('/root/World/Gui').hide_poi_label_panel()

# on click: show text box or perform other action
func _input(event):
	if event is InputEventMouseButton and event.pressed:
		var mouse_pos_global = get_viewport().get_mouse_position()
		var tile_pos = local_to_map(mouse_pos_global)
		var tile_data = get_cell_tile_data(tile_pos)
		if tile_data is TileData:
			var name = tile_data.get_custom_data("name")
			var hidden = tile_data.get_custom_data("hidden")
			if name and !hidden:
				get_node('/root/World/Gui').click_poi_or_item(name)
