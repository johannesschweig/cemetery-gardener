class_name MyTileMapLayer extends TileMapLayer

var cursor = load("res://assets/cursor.png")
var pointer = load("res://assets/pointer.png")
var gui
var stage
var showing_poi_panel = false
var tiles : Array
var time

func _ready() -> void:
	gui = get_node('/root/World/Gui')
	stage = get_node('/root/World/Stage')
	gui.discovered_location.connect(update_switched_locations)
	gui.switched_location.connect(update_switched_locations)
	update_switched_locations()
	tiles = Utils.get_all_tiles(self)
	time = Time.get_unix_time_from_system()
	

func update_switched_locations():
	if gui.switched_locations:
		for pair in gui.switched_locations:
			var original_location = pair[0]
			var new_location = pair[1]
			var original_props = Utils.get_coords_and_tile_pos_in_tile_map(original_location, self)
			# if tile not part of current tile map
			if original_props:
				var original_coords = original_props.coords
				var original_id = original_props.id
				var new_coords = Utils.find_coords_in_atlas(new_location, self)
				self.set_cell(original_coords, original_id, new_coords)

# returns tile position, name, discovered state fo the currently hovered tile
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

func _process(_delta):
	print(Time.get_unix_time_from_system() - time)
	time = Time.get_unix_time_from_system()
	if stage.is_visible_in_tree():
		var tile_props = get_tile_props()
		var tile_pos = tile_props.tile_pos
		for tile in tiles:
			if Utils.is_origin_inside(tile_pos, tile.start, tile.end):
				#print('this is ', tile.name, 'at ', tile_pos)
				if !self.get_children() and tile.undiscovered == false:
					var name_formatted = Utils.get_title_from_identifier(tile.name)
					# change cursor and show poi label if hovering
					var position = map_to_local(tile.origin) - Vector2((len(tile.name) * 17) / 2, 20)
					# change cursor
					Input.set_custom_mouse_cursor(pointer)
					gui.show_poi_label_panel(name_formatted, position)
					showing_poi_panel = true
				else:
					Input.set_custom_mouse_cursor(cursor)
					gui.hide_poi_label_panel()
					showing_poi_panel = false
				return
		# if no tile found: hide poi_panel
		Input.set_custom_mouse_cursor(cursor)
		gui.hide_poi_label_panel()
		showing_poi_panel = false

# on click: show text box or perform other action
func _input(event):
	if stage.is_visible_in_tree() and event is InputEventMouseButton and event.pressed:
		var tile_props = get_tile_props()
		var name = tile_props.name
		var undiscovered = tile_props.undiscovered
		if name and undiscovered == false:
			gui.click_poi_or_item(name)

# hide poi panel on map change
func _exit_tree() -> void:
	Input.set_custom_mouse_cursor(cursor)
	gui.hide_poi_label_panel()
