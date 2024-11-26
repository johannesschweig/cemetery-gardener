extends PanelContainer

@export var items : Array = []


func _ready() -> void:
	var inventory_item = preload("res://elements/gui/inventory_item.tscn")
	var items = get_node("/root/World/Gui/Inventory").inventory.filter(func(item): return item.status == Utils.ItemStatus.INITIAL)
	for item in items:
		var new_item = inventory_item.instantiate()
		new_item.set_item(item)
		%ItemsGrid.add_child(new_item)
