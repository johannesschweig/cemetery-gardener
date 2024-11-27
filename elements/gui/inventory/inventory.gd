extends Control

@onready var items_grid: GridContainer = %ItemsGrid
@onready var empty: Label = %Empty
@onready var items: PanelContainer = %Items
@onready var inventory_panel: Control = %InventoryPanel
@onready var open_inventory: MyButton = %OpenInventory

var inventory = [
	{
		"identifier": "letters",
		"description": "tfkkar cdgjbp",
		"status": Utils.ItemStatus.INITIAL,
		"unlock": true,
		"solution": "thomas dehler",
	},
	{
		"identifier": "notes_with_code",
		"description": "024201 111232",
		"status": Utils.ItemStatus.INITIAL,
		"unlock": true,
		"solution": "thomas dehler",
	},
	{
		"identifier": "car_key",
		"description": "From an Opel",
		"status": Utils.ItemStatus.INITIAL,
	},
	{
		"identifier": "spare_key",
		"description": "An old, heavy metal key with a key tag 'spare key crematorium'",
		"status": Utils.ItemStatus.INITIAL,
	},
	{
		"identifier": "hammer",
		"description": "A large hammer that fits well in your hand.",
		"status": Utils.ItemStatus.INITIAL,
	},
	{
		"identifier": "travel_flyer",
		"description": "Palm trees. Beach. Sea.",
		"status": Utils.ItemStatus.INITIAL,
	},
	{
		"identifier": "mobile_phone",
		"description": "An old nokia mobile phone with an antenna.",
		"status": Utils.ItemStatus.INITIAL,
		"unlock": true,
		"solution": "1999"
	},
	{
		"identifier": "spade",
		"description": "With a T-handle.",
		"status": Utils.ItemStatus.INITIAL
	},
	{
		"identifier": "newspaper_article",
		"description": "From the 13th September 2000",
		"status": Utils.ItemStatus.INITIAL
	},
]

func get_items():
	return inventory.filter(func(item): return item.status != Utils.ItemStatus.INITIAL)

func get_number_of_items() -> int:
	return len(get_items())

# whether the player has found an item yet
func get_status(identifier: String):
	return inventory.filter(func(el): return el.identifier == identifier)[0].status

func set_status(identifier, status: Utils.ItemStatus):
	var items
	if typeof(identifier) == TYPE_ARRAY:
		items = identifier
	else:
		items = [identifier]
		
	# loop through items
	for item in items:
		var found_identifier = -1
		for i in range(inventory.size()):
			if inventory[i].identifier == item:
				found_identifier = i
				break
		inventory[found_identifier].status = status
	update_label_text()

func get_description(identifier: String):
	return inventory.filter(func(el): return el.identifier == identifier)[0].description

func update_label_text():
	var foundItems = get_number_of_items()
	if foundItems == 0:
		open_inventory.text = "Open Inventory (Empty)"
	else:
		open_inventory.text = "Open Inventory (%s)" % foundItems


func _on_open_inventory_pressed() -> void:
	open_inventory.visible = false
	inventory_panel.visible = true
	if get_number_of_items():
		items.update_items()
		items_grid.visible = true
		empty.visible = false
	else:
		items_grid.visible = false
		empty.visible = true

func _on_close_pressed() -> void:
	open_inventory.visible = true
	inventory_panel.visible = false
