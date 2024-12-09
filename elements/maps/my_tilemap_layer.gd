class_name MyTileMapLayer extends TileMapLayer

var cursor = load("res://assets/cursor.png")
var pointer = load("res://assets/pointer.png")
var gui
var stage
var showing_poi_panel = false
var tiles : Array

func _ready() -> void:
	gui = get_node('/root/World/Gui')
	stage = get_node('/root/World/Stage')
	gui.discovered_location.connect(update_switched_locations)
	gui.switched_location.connect(update_switched_locations)
	update_switched_locations()
	tiles = Utils.get_all_tiles(self)
	

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
		# update tiles that show up
		tiles = Utils.get_all_tiles(self)

func _process(_delta):
	if stage.is_visible_in_tree():
		var data = Utils.get_name_position(self, gui.discovered_locations, tiles)
		if data:
			var name_formatted = Utils.get_title_from_identifier(data.name)
			# change cursor
			Input.set_custom_mouse_cursor(pointer)
			gui.show_poi_label_panel(name_formatted, data.position)
			showing_poi_panel = true
		else:
			# if no tile found: hide poi_panel
			Input.set_custom_mouse_cursor(cursor)
			gui.hide_poi_label_panel()
			showing_poi_panel = false

# on click: show text box or perform other action
func _unhandled_input(event: InputEvent):
	if stage.is_visible_in_tree() and event is InputEventMouseButton and event.pressed:
		var data = Utils.get_name_position(self, gui.discovered_locations, tiles)
		if data:
			gui.click_poi_or_item(data.name)

# hide poi panel on map change
func _exit_tree() -> void:
	Input.set_custom_mouse_cursor(cursor)
	gui.hide_poi_label_panel()
