extends PanelContainer

@export var items : Array = []

func update_items():
	var inventory_item = preload("res://elements/gui/inventory_item.tscn")
	var items = get_node("/root/World/Gui/Inventory").inventory.filter(func(item): return item.status != Utils.ItemStatus.INITIAL)
	Utils.clear_children(%ItemsGrid)
	for item in items:
		var new_item = inventory_item.instantiate()
		new_item.set_item(item)
		%ItemsGrid.add_child(new_item)

func _ready() -> void:
	update_items()
