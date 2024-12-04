extends Control

@onready var items_grid: GridContainer = %ItemsGrid
@onready var empty: Label = %Empty
@onready var items: PanelContainer = %Items
@onready var inventory_panel: Control = %InventoryPanel
@onready var open_inventory: MyButton = %OpenInventory
var stage

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
		"description": "FROM_OPEL",
		"status": Utils.ItemStatus.INITIAL,
	},
	{
		"identifier": "spare_key",
		"description": "SPARE_KEY_DESC",
		"status": Utils.ItemStatus.INITIAL,
	},
	{
		"identifier": "hammer",
		"description": "HAMMER_DESC",
		"status": Utils.ItemStatus.INITIAL,
	},
	{
		"identifier": "travel_flyer",
		"description": "TRAVEL_FLYER_DESC",
		"status": Utils.ItemStatus.INITIAL,
	},
	{
		"identifier": "mobile_phone",
		"description": "MOBILE_PHONE_DESC",
		"status": Utils.ItemStatus.INITIAL,
		"unlock": true,
		"solution": "1999"
	},
	{
		"identifier": "spade",
		"description": "SPADE_DESC",
		"status": Utils.ItemStatus.INITIAL
	},
	{
		"identifier": "newspaper_article",
		"description": "NEWSPAPER_ARTICLE_DESC",
		"status": Utils.ItemStatus.INITIAL
	},
]

func _ready() -> void:
	stage = get_node("/root/World/Stage")

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
		open_inventory.text = tr("OPEN_INVENTORY_EMPTY")
	else:
		open_inventory.text = tr("OPEN_INVENTORY_ITEMS") % foundItems


func _on_open_inventory_pressed() -> void:
	open_inventory.hide()
	inventory_panel.show()
	stage.hide()
	if get_number_of_items():
		items.update_items()
		items_grid.show()
		empty.hide()
	else:
		items_grid.hide()
		empty.show()

func _on_close_pressed() -> void:
	open_inventory.show()
	inventory_panel.hide()
	stage.show()
