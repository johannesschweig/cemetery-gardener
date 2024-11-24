extends CanvasLayer

func getLabelText() -> String:
	var foundItems = GameManager.getNumberOfFoundItems()
	if foundItems == 0:
		return "Open Inventory (Empty)"
	else:
		return "Open Inventory (%s)" % foundItems

func _ready() -> void:
	GameManager.item_found.connect(_on_item_found)
	%OpenInventory.text = getLabelText()
	%PoiLabelPanel.visible = false

func _on_button_pressed() -> void: # TODO no change in scene pls
	get_tree().change_scene_to_file("res://elements/mess/inventory.tscn")

func _on_item_found() -> void:
	%OpenInventory.text = getLabelText()
	
func showPoiLabelPanel(name: String, position: Vector2):
	%PoiLabelPanel.visible = true
	%PoiLabelPanel.position = position
	%PoiLabelPanel.setName(name)

func hidePoiLabelPanel():
	%PoiLabelPanel.visible = false
#
#func _ready() -> void:
	#name_panel = %PoiLabelPanel
	#name_label = %PoiLabel
	#self.remove_child(name_panel)
	##name_panel.set_anchors_preset(Control.PRESET_CENTER) # TODO does not work
#
#func _process(_delta):
	#var mouse_pos_global = get_viewport().get_mouse_position()
	#var tile_pos = local_to_map(mouse_pos_global)
	#var tile_data = get_cell_tile_data(tile_pos)
	#if tile_data is TileData:
		#var name = GameManager.getTitleFromIdentifier(tile_data.get_custom_data("name"))
		#if !self.get_children() and name:
			#name_label.text = name
			## center the label
			#name_panel.position = map_to_local(tile_pos) - Vector2((len(name) * 17) / 2, 20)
			#add_child(name_panel)
			## change cursor
			#Input.set_custom_mouse_cursor(pointer)
	#else:
		#Input.set_custom_mouse_cursor(cursor)
		#if self.get_children():
			#self.remove_child(name_panel)
