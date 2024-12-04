extends PanelContainer

var items : Array = []
@export var inventory_item : PackedScene
@onready var items_grid: GridContainer = %ItemsGrid

func update_items():
	var items = get_node("/root/World/Gui/InventoryPanel").get_items()
	Utils.clear_children(items_grid)
	for item in items:
		var new_item = inventory_item.instantiate()
		new_item.set_item(item)
		items_grid.add_child(new_item)

func _ready() -> void:
	update_items()
