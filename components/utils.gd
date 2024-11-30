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

# returns the coords of a tile in the atlas with a given name
func find_coords_in_atlas(name: String, tile_map_layer: TileMapLayer):
	var tileset : TileSet = tile_map_layer.tile_set  # Get the TileSet from the TileMap
	
	# Iterate over all the tiles in the TileSet
	var tileset_source : TileSetSource = tileset.get_source(1)
	for i in range(tileset_source.get_tiles_count()):
		var data : TileData = tileset_source.get_tile_data(tileset_source.get_tile_id(i),0)
		var cell_name : String = data.get_custom_data('name')
		var coords : Vector2i = tileset_source.get_tile_id(i)
		if cell_name:
			if cell_name == name:
				return coords

# get coords and tile position in current tile map with a given name
func get_coords_and_tile_pos_in_tile_map(name: String, tile_map_layer: TileMapLayer):
	# Get the used area of the TileMap (the rectangle that contains all the tiles in use)
	var used_rect : Rect2i = tile_map_layer.get_used_rect()
	# Iterate over the area, checking each tile position
	for x in range(used_rect.position.x, used_rect.position.x + used_rect.size.x):
		for y in range(used_rect.position.y, used_rect.position.y + used_rect.size.y):
			var tile_pos : Vector2 = Vector2(x, y)
			var tile_id : int = tile_map_layer.get_cell_source_id(tile_pos)  # Get the ID of the tile at this position
			# You can also get custom data if needed
			var tile_data : TileData = tile_map_layer.get_cell_tile_data(tile_pos)
			# Example: print information about each tile
			if tile_id != -1:  # Ensure the tile exists (ID of -1 means no tile)
				if tile_data:
					var cell_name : String = tile_data.get_custom_data("name")  # Get custom data (if set)
					if cell_name == name:
						return {
							'id': tile_id,
							'coords': tile_pos
						}

func get_tiles_from_tileset(tile_map_layer: TileMapLayer):
		# Iterate over all tiles in tileset
	var available_cells = []
	var tileset : TileSet = tile_map_layer.tile_set  # Get the TileSet from the TileMap
	var tile_size : Vector2i = tileset.get_tile_size()
	# Iterate over all the tiles in the TileSet
	var tileset_source : TileSetSource = tileset.get_source(1)
	for i in range(tileset_source.get_tiles_count()):
		var data : TileData = tileset_source.get_tile_data(tileset_source.get_tile_id(i), 0)
		var tile_name : String = data.get_custom_data('name')
		var coords : Vector2i = tileset_source.get_tile_id(i)
		if tile_name:
			available_cells += [{
				"name": tile_name,
				"atlas_coords": coords,
				"size": tileset_source.get_tile_size_in_atlas(coords),
				"texture_origin": data.get_texture_origin(),
			}]
	return available_cells

# return props of all tiles currently visible on the tile map layer
func get_all_tiles(tile_map_layer: TileMapLayer):
	var used_cells = []
	var used_rect : Rect2i = tile_map_layer.get_used_rect()
	# Iterate over the area, checking each tile position
	for x in range(used_rect.position.x, used_rect.position.x + used_rect.size.x):
		for y in range(used_rect.position.y, used_rect.position.y + used_rect.size.y):
			var tile_pos : Vector2 = Vector2(x, y)
			var tile_id : int = tile_map_layer.get_cell_source_id(tile_pos)
			var tile_data : TileData = tile_map_layer.get_cell_tile_data(tile_pos)
			if tile_id != -1 and tile_data and tile_data.get_custom_data("name"):  # Ensure the tile exists (ID of -1 means no tile)
				used_cells += [{
					"origin": tile_pos,
					"name": tile_data.get_custom_data("name"),
					"undiscovered": tile_data.get_custom_data("undiscovered"),
				}]
	# get all tiles from tileset
	var available_cells = get_tiles_from_tileset(tile_map_layer)
	
	# add info to used cells
	var enriched_cells = []
	for used_cell in used_cells:
		for available_cell in available_cells:
			if used_cell.name == available_cell.name:
				enriched_cells += [{
					"name": used_cell.name,
					"origin": used_cell.origin,
					"undiscovered": used_cell.undiscovered,
					"atlas_coords": available_cell.atlas_coords,
					"size": available_cell.size,
					"texture_origin": available_cell.texture_origin,
				}]
	return enriched_cells
