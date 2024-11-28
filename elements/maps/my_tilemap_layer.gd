class_name MyTileMapLayer extends TileMapLayer

var cursor = load("res://assets/cursor.png")
var pointer = load("res://assets/pointer.png")
var gui
var showing_poi_panel = false

func update_switched_locations():
	if gui.switched_locations:
		for pair in gui.switched_locations:
			var original_location = pair[0]
			var new_location = pair[1]
			var original_props = get_coords_and_tile_pos_in_tile_map(original_location)
			# if tile not part of current tile map
			if original_props:
				var original_coords = original_props.coords
				var original_id = original_props.id
				var new_coords = find_coords_in_atlas(new_location)
				self.set_cell(original_coords, original_id, new_coords)

func _ready() -> void:
	gui = get_node('/root/World/Gui')
	gui.discovered_location.connect(update_switched_locations)
	gui.switched_location.connect(update_switched_locations)
	update_switched_locations()

func find_coords_in_atlas(name: String):
	var tileset = self.tile_set  # Get the TileSet from the TileMap
	
	# Iterate over all the tiles in the TileSet
	var tileset_source = tileset.get_source(1)
	for i in range(tileset_source.get_tiles_count()):
		var data : TileData = tileset_source.get_tile_data(tileset_source.get_tile_id(i),0)
		var cell_name = data.get_custom_data('name')
		var coords = tileset_source.get_tile_id(i)
		if cell_name:
			if cell_name == name:
				return coords

func get_coords_and_tile_pos_in_tile_map(name: String):
	# Get the used area of the TileMap (the rectangle that contains all the tiles in use)
	var used_rect = get_used_rect()
	
	# Iterate over the area, checking each tile position
	for x in range(used_rect.position.x, used_rect.position.x + used_rect.size.x):
		for y in range(used_rect.position.y, used_rect.position.y + used_rect.size.y):
			var tile_pos = Vector2(x, y)
			var tile_id = get_cell_source_id(tile_pos)  # Get the ID of the tile at this position
			# You can also get custom data if needed
			var tile_data = get_cell_tile_data(tile_pos)
			# Example: print information about each tile
			if tile_id != -1:  # Ensure the tile exists (ID of -1 means no tile)
				if tile_data:
					var cell_name = tile_data.get_custom_data("name")  # Get custom data (if set)
					if cell_name == name:
						return {
							'id': tile_id,
							'coords': tile_pos
						}

func get_tile_props():
	var mouse_pos_global = get_viewport().get_mouse_position()
	var tile_pos = local_to_map(mouse_pos_global)
	var tile_data = get_cell_tile_data(tile_pos)
	var name = tile_data.get_custom_data("name") if tile_data else ""
	var undiscovered = tile_data.get_custom_data("undiscovered") if tile_data and tile_data.get_custom_data("undiscovered") else false
	# check if name in list of discovered locations
	if name and name in gui.discovered_locations:
		undiscovered = false
	return {
		"tile_pos": tile_pos,
		"name": name,
		"undiscovered": undiscovered
	}

# on hover: change cursor and show label
func _process(_delta):
	var tile_props = get_tile_props()
	var tile_pos = tile_props.tile_pos
	var name = tile_props.name
	var undiscovered = tile_props.undiscovered
	if name:
		if !self.get_children() and undiscovered == false:
			var name_formatted = Utils.get_title_from_identifier(name)
			# change cursor and show poi label if hovering
			var position = map_to_local(tile_pos) - Vector2((len(name) * 17) / 2, 20)
			# change cursor
			Input.set_custom_mouse_cursor(pointer)
			gui.show_poi_label_panel(name_formatted, position)
			showing_poi_panel = true
		else:
			Input.set_custom_mouse_cursor(cursor)
			gui.hide_poi_label_panel()
			showing_poi_panel = false
	elif showing_poi_panel:
		Input.set_custom_mouse_cursor(cursor)
		gui.hide_poi_label_panel()
		showing_poi_panel = false

# on click: show text box or perform other action
func _input(event):
	if event is InputEventMouseButton and event.pressed:
		var tile_props = get_tile_props()
		var name = tile_props.name
		var undiscovered = tile_props.undiscovered
		if name and undiscovered == false:
			gui.click_poi_or_item(name)

# hide poi panel on map change
func _exit_tree() -> void:
	Input.set_custom_mouse_cursor(cursor)
	gui.hide_poi_label_panel()
