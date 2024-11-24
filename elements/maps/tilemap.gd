extends TileMapLayer

var name_label
var name_panel
var cursor = load("res://assets/cursor.png")
var pointer = load("res://assets/pointer.png")

func _ready() -> void:
	name_panel = %PoiLabelPanel
	name_label = %PoiLabel
	self.remove_child(name_panel)
	#name_panel.set_anchors_preset(Control.PRESET_CENTER) # TODO does not work

func _process(_delta):
	var mouse_pos_global = get_viewport().get_mouse_position()
	var tile_pos = local_to_map(mouse_pos_global)
	var tile_data = get_cell_tile_data(tile_pos)
	if tile_data is TileData:
		var name = GameManager.getTitleFromIdentifier(tile_data.get_custom_data("name"))
		if !self.get_children() and name:
			name_label.text = name
			# center the label
			name_panel.position = map_to_local(tile_pos) - Vector2((len(name) * 17) / 2, 20)
			add_child(name_panel)
			# change cursor
			Input.set_custom_mouse_cursor(pointer)
	else:
		Input.set_custom_mouse_cursor(cursor)
		if self.get_children():
			self.remove_child(name_panel)
