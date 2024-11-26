extends Control

enum ItemStatus {
	INITIAL,
	FOUND,
	USED
}

var inventory = [
	{
		"id": 34,
		"identifier": "letters",
		"description": "tfkkar cdgjbp",
		"status": ItemStatus.INITIAL,
		"icon": "characters",
		"unlock": true,
		"solution": "thomas dehler",
	},
	{
		"id": 33,
		"identifier": "notes_with_code",
		"description": "024201 111232",
		"status": ItemStatus.INITIAL,
		"icon": "code",
		"unlock": true,
		"solution": "thomas dehler",
	},
	{
		"id": 20,
		"identifier": "car_key",
		"description": "From an Opel",
		"status": ItemStatus.INITIAL,
		"icon": "carKey",
	},
	{
		"id": 22,
		"identifier": "spare_key",
		"description": "An old, heavy metal key with a key tag 'spare key crematorium'",
		"status": ItemStatus.INITIAL,
		"icon": "crematoriumKey",
	},
	{
		"id": 24,
		"identifier": "hammer",
		"description": "An large hammer that fits well in your hand.",
		"status": ItemStatus.INITIAL,
		"icon": "hammer",
	},
	{
		"id": 30,
		"identifier": "travel_flyer",
		"description": "Palm trees. Beach. Sea.",
		"status": ItemStatus.INITIAL,
		"icon": "flyer",
	},
	{
		"id": 25,
		"identifier": "mobile_phone",
		"description": "An old nokia mobile phone with an antenna.",
		"status": ItemStatus.INITIAL,
		"icon": "mobilePhone",
		"unlock": true,
		"solution": "1999"
	},
	{
		"id": 31,
		"identifier": "spade",
		"description": "With a T-handle.",
		"status": ItemStatus.INITIAL,
		"icon": "spade",
	},
	{
		"id": 35,
		"identifier": "newspaper_article",
		"description": "From the 13th September 2000",
		"status": ItemStatus.INITIAL,
		"icon": "newsArticle"
	},
]

# whether the player has found an item yet
func get_status(id: int):
	return inventory.filter(func(el): return el.id == id)[0].status

func set_status(id: int, status: ItemStatus):
	var found_id = -1
	for i in range(inventory.size()):
		if inventory[i].id == id:
			found_id = i
			break
	inventory[found_id].status = status
	if status == ItemStatus.FOUND:
		# TODO globals
		var found_identifier = inventory[found_id].identifier
		var found_icon = inventory[found_id].icon
	#emit_signal("item_found") # TODO
