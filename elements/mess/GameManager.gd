extends Node2D

signal crematorium_key_found()
signal chest_found()
signal item_found()

# show all items, hide title screen
@export var debug = false
# for inventory back switching
@export var current_area = "map" # TODO remove
# last found item
@export var found_identifier = ''
@export var found_icon = ''

enum ITEM_STATUS {
	INITIAL,
	FOUND,
	USED
}


@export var inventory = [
	{
		"id": 34,
		"identifier": "letters",
		"description": "tfkkar cdgjbp",
		"status": ITEM_STATUS.INITIAL,
		"icon": "characters",
		"unlock": true,
		"solution": "thomas dehler",
	},
	{
		"id": 33,
		"identifier": "notes_with_code",
		"description": "024201 111232",
		"status": ITEM_STATUS.INITIAL,
		"icon": "code",
		"unlock": true,
		"solution": "thomas dehler",
	},
	{
		"id": 20,
		"identifier": "car_key",
		"description": "From an Opel",
		"status": ITEM_STATUS.INITIAL,
		"icon": "carKey",
	},
	{
		"id": 22,
		"identifier": "spare_key",
		"description": "An old, heavy metal key with a key tag 'spare key crematorium'",
		"status": ITEM_STATUS.INITIAL,
		"icon": "crematoriumKey",
	},
	{
		"id": 24,
		"identifier": "hammer",
		"description": "An large hammer that fits well in your hand.",
		"status": ITEM_STATUS.INITIAL,
		"icon": "hammer",
	},
	{
		"id": 30,
		"identifier": "travel_flyer",
		"description": "Palm trees. Beach. Sea.",
		"status": ITEM_STATUS.INITIAL,
		"icon": "flyer",
	},
	{
		"id": 25,
		"identifier": "mobile_phone",
		"description": "An old nokia mobile phone with an antenna.",
		"status": ITEM_STATUS.INITIAL,
		"icon": "mobilePhone",
		"unlock": true,
		"solution": "1999"
	},
	{
		"id": 31,
		"identifier": "spade",
		"description": "With a T-handle.",
		"status": ITEM_STATUS.INITIAL,
		"icon": "spade",
	},
	{
		"id": 35,
		"identifier": "newspaper_article",
		"description": "From the 13th September 2000",
		"status": ITEM_STATUS.INITIAL,
		"icon": "newsArticle"
	},
]

@export var pois : Array = [
	{
		"identifier": "grave_field",
		"area": "map",
		"x": 1160,
		"y": 550,
		"width": 550,
		"height": 50,
	},
	{
		"identifier": "gravestone",
		"area": "map",
		"x": 1550,
		"y": 800,
		"width": 140,
		"height": 70,
		"hidden": true,
	},
	{
		"identifier": "fountain",
		"area": "map",
		"x": 800,
		"y": 560,
		"width": 270,
		"height": 250,
	},
	{
		"identifier": "police_car",
		"area": "map",
		"x": 1040,
		"y": 1170,
		"width": 150,
		"height": 200,
	},
	{
		"identifier": "opel",
		"area": "map",
		"x": 760,
		"y": 1170,
		"width": 150,
		"height": 200,
		"hidden": true,
	},
	{
		"identifier": "parking_lot",
		"area": "map",
		"x": 780,
		"y": 1120,
		"width": 300,
		"height": 40,
	},
	{
		"identifier": "sofa",
		"area": "house",
		"x": 900,
		"y": 350,
		"width": 120,
		"height": 340,
	},
	{
		"identifier": "photo",
		"area": "house",
		"x": 1300,
		"y": 1300,
		"width": 150,
		"height": 80,
	},
	{
		"identifier": "answering_machine",
		"area": "house",
		"x": 840,
		"y": 930,
		"width": 250,
		"height": 80,
	},
	{
		"identifier": "wardrobe",
		"area": "house",
		"x": 300,
		"y": 800,
		"width": 300,
		"height": 140,
	},
	{
		"identifier": "bed",
		"area": "house",
		"x": 280,
		"y": 1100,
		"width": 180,
		"height": 230,
	},
	{
		"identifier": "leaning_spade",
		"area": "house",
		"x": 310,
		"y": 1400,
		"width": 200,
		"height": 80,
	},
	{
		"identifier": "flower_vases",
		"area": "house",
		"x": 1100,
		"y": 1400,
		"width": 200,
		"height": 80,
		"hidden": true,
	},
	{
		"identifier": "seating",
		"area": "chapel",
		"x": 550,
		"y": 600,
		"width": 650,
		"height": 400,
	},
	{
		"identifier": "stand",
		"area": "chapel",
		"x": 750,
		"y": 350,
		"width": 200,
		"height": 200,
	},
	{
		"identifier": "carts",
		"area": "cellar",
		"x": 650,
		"y": 1050,
		"width": 400,
		"height": 300,
	},
	{
		"identifier": "mud",
		"area": "cellar",
		"x": 400,
		"y": 775,
		"width": 250,
		"height": 150,
	},
	{
		"identifier": "hatch",
		"area": "cellar",
		"x": 500,
		"y": 300,
		"width": 400,
		"height": 400,
	},
]


@export var submaps = [
	{
		"identifier": "house",
		"area": "map",
		"x": 200,
		"y": 550,
		"width": 300,
		"height": 300,
	},
	{
		"identifier": "chapel",
		"area": "map",
		"x": 750,
		"y": 70,
		"width": 300,
		"height": 400,
	},
]

func get_pois_area():
	return pois.filter(func(el): return el.area == current_area and (not "hidden" in el or el.hidden == false))

func get_submaps_area():
	return submaps.filter(func(el): return el.area == current_area and (not "hidden" in el or el.hidden == false))
	



# show previously hidden poi on map
func show_poi(identifier):
	for el in pois:
		if el.identifier == identifier:
			el.hidden = false
			break


# turn identifiers into human readable titles
func getTitleFromIdentifier(identifier: String):
	return identifier.replace("_", " ").capitalize()

# a button of a poi or inventory item is clicked
func click_button(identifier: String):
	var path
	if get_node_or_null("/root/World"): # map or submap
		path = "/root/World/stage/map/Camera/TextBox"
	else: # inventory
		path = "/root/inventory/TextBox" # TODO
	if identifier == "opel": # end of game
		get_tree().change_scene_to_file("res://elements/end/end.tscn")
	else:
		#get_node(path).setTextBox(getTitleFromIdentifier(identifier), get_text(identifier), getTitleFromIdentifier(found_identifier), found_icon)
		found_identifier = ''
		found_icon = ''

# open the unlock dialoge on an item in the inventory
func click_unlock(identifier: String, solution: String):
	var path = "/root/inventory/UnlockBox" # TODO
	get_node(path).setUnlockBox(identifier, solution)
