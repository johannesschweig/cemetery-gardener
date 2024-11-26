extends Control

enum ItemStatus {
	INITIAL,
	FOUND,
	USED
}

var inventory = [
	{
		"identifier": "letters",
		"description": "tfkkar cdgjbp",
		"status": ItemStatus.INITIAL,
		"icon": "characters",
		"unlock": true,
		"solution": "thomas dehler",
	},
	{
		"identifier": "notes_with_code",
		"description": "024201 111232",
		"status": ItemStatus.INITIAL,
		"icon": "code",
		"unlock": true,
		"solution": "thomas dehler",
	},
	{
		"identifier": "car_key",
		"description": "From an Opel",
		"status": ItemStatus.INITIAL,
		"icon": "carKey",
	},
	{
		"identifier": "spare_key",
		"description": "An old, heavy metal key with a key tag 'spare key crematorium'",
		"status": ItemStatus.INITIAL,
		"icon": "crematoriumKey",
	},
	{
		"identifier": "hammer",
		"description": "An large hammer that fits well in your hand.",
		"status": ItemStatus.INITIAL,
		"icon": "hammer",
	},
	{
		"identifier": "travel_flyer",
		"description": "Palm trees. Beach. Sea.",
		"status": ItemStatus.INITIAL,
		"icon": "flyer",
	},
	{
		"identifier": "mobile_phone",
		"description": "An old nokia mobile phone with an antenna.",
		"status": ItemStatus.INITIAL,
		"icon": "mobilePhone",
		"unlock": true,
		"solution": "1999"
	},
	{
		"identifier": "spade",
		"description": "With a T-handle.",
		"status": ItemStatus.INITIAL,
		"icon": "spade",
	},
	{
		"identifier": "newspaper_article",
		"description": "From the 13th September 2000",
		"status": ItemStatus.INITIAL,
		"icon": "newsArticle"
	},
]

# whether the player has found an item yet
func get_status(identifier: String):
	return inventory.filter(func(el): return el.identifier == identifier)[0].status

func set_status(identifier: String, status: ItemStatus):
	var found_identifier = -1
	for i in range(inventory.size()):
		if inventory[i].identifier == identifier:
			found_identifier = i
			break
	inventory[found_identifier].status = status
	#emit_signal("item_found") # TODO update inventory label
