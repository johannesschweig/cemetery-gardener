extends Node2D

signal crematorium_key_found()
signal chest_found()
signal item_found()

# show all items, hide title screen
@export var debug = false
# for inventory back switching
@export var current_area = "map"
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
	
# whether the player has found an item yet
func status(id: int):
	return inventory.filter(func(el): return el.id == id)[0].status
	
func getNumberOfFoundItems():
	return len(inventory.filter(func(item): return item.status != ITEM_STATUS.INITIAL))

func get_text(current_element: String):
	match current_element:
		"fountain":
			if status(24) == ITEM_STATUS.INITIAL:
				return "It is an old stone fountain with a statue in the middle. It is completely frozen over. Under you can see a fist-sized rectangular object under the ice. You knock against the ice. It is several centimeters thick."
			elif status(24) == ITEM_STATUS.FOUND:
				update_status(25, ITEM_STATUS.FOUND)
				update_status(24, ITEM_STATUS.USED)
				return "You take the hammer in your hand and hit the ice. The ice shatters and cold water splashes in your face. You fish for the object with your other hand and pull it out with numb fingers."
			else:
				return "It is an old stone fountain with a statue in the middle. The water is frozen over. There is a hole in the ice where you broke it with the hammer."
		"police_car":
			if status(24) == ITEM_STATUS.INITIAL:
				update_status(24, ITEM_STATUS.FOUND)
				return "A VW Golf police car with green stripes on the side. You remember that you still have a hammer in the trunk. Maybe it can still come in handy."
			else:
				return "A VW Golf police car with green stripes on the side. You already looked through your trunk."
		"grave_field":
			return "In the burial ground, graves with gravestones stand in neat rows on the icy meadow."
		"parking_lot":
			return "A normal parking lot paved with gray concrete blocks. Next to your car there are two other cars. No one is sitting in them."
		"sofa": 
			if status(30) == ITEM_STATUS.INITIAL:
				update_status(30, ITEM_STATUS.FOUND)
				return "An old light brown leather sofa with a travel brochure lying on it."
			else:
				return "An old light brown leather sofa."
		"photo": 
			if status(34) == ITEM_STATUS.INITIAL:
				update_status(34, ITEM_STATUS.FOUND)
				return "The photo shows a young woman. She is probably in her early 20s. She has brown hair, is wearing earrings and lipstick. She is smiling confidently into the camera. On the back is handwritten in dark ink “Inna, 1998” and in the bottom right corner is a cross with strange letters that make no sense. You note it down."
			else:
				return "You already examined the photo of the young woman and noted down the strange letters."
		"answering_machine":
			return "You can see a red 5 on the answering machine display. You listen to the messages. The first is from 2 weeks ago, a florist has to cancel a delivery. The second is from a withheld number, no message was left. The third is from the local baker 1 week ago: “Boris, it might be strange, but there were some strange men here just now who asked about you. But they didn’t want to say what for. I just said where they can find you. I hope you don’t get into trouble.” The fourth and fifth are the cemetery manager, a little grumpy at first (3 days ago), then more concerned (2 days ago)."
		"wardrobe":
			if status(33) == ITEM_STATUS.INITIAL:
				update_status(33, ITEM_STATUS.FOUND)
				return "An old white wardrobe. You open the doors and find that it is empty except for a few T-shirts. Down on the floor you find a notebook. You leaf through the notebook and find shopping lists, a half-finished letter in Cyrillic and incomprehensible schematic drawings. As you leaf through it, a piece of paper falls out."
			else: 
				return "An old white wardrobe. You open the doors and find that it is empty except for a few T-shirts."
		"bed":
			return "On the metal frame lies a mattress with a checked blanket, pillows and a bedspread with flowers on it. Under the mattress you find a men's magazine called \"Wochenend\". Next to a scantily clad woman are the headlines \"The truth about syphilis is so horrific\", \"Farmer Benno\'s marriage candidate turned out to be a massage girl\" and \"Prostitution: It is so dangerous to make a living from paid love today\". You find nothing else."
		"leaning_spade":
			if status(31) == ITEM_STATUS.INITIAL:
				update_status(31, ITEM_STATUS.FOUND)
				return "The spade still looks to be in good shape. You take it with you as a precaution."
			else:
				return "You picked up the spade here."
		"flower_vases":
			if (status(22) == ITEM_STATUS.INITIAL):
				update_status(22, ITEM_STATUS.FOUND)
				return "You hadn't even noticed the flower vases next to the entrance before. You examine them and you find a key in the middle one."
			return "You found a key here."
		"seating":
			return "To the left and right there are neat rows of wooden chairs with red cushions. You walk down the rows but don't find anything."
		"stand":
			return "The wooden stand is at the end of the room, along with a few large candle holders. You don't find anything interesting."
		"gate":
			if status(22) == ITEM_STATUS.INITIAL:
				return "The gate is about 5 paces wide and made of dark wood with metal fittings. It looks very solid. In the middle you can see a keyhole. You shake it, but it doesn't open."
			else:
				emit_signal("crematorium_key_found")
				update_status(22, ITEM_STATUS.USED)
				return "The heavy metal key fits perfectly into the gate lock. You turn the key in the lock and open the gate."
		"carts":
			if status(20) == ITEM_STATUS.INITIAL:
				update_status(20, ITEM_STATUS.FOUND)
				show_poi("opel")
				return "The metal carts are made of stainless steel tubes and are 1 meter high with 4 small wheels each. When you try to push one of them to the side, a wheel blocks and you find a car key underneath."
			else:
				return "The metal carts are made of stainless steel tubes and are 1 meter high with 4 small wheels each."
		"mud":
			return "You examine the mud on the ground more closely and can see a footprint. You estimate the shoe size to be at least 43."
		"gravestone":
			if status(31) == ITEM_STATUS.INITIAL:
				return "A little way away from the other graves you find the dark gravestone of Thomas Dehler with the dates of his death and a dedication \"And forgive us our sins\". A few smaller sandstone slabs are leaning against the back of the gravestone. You put them to one side and notice that the ground is trodden down and bare of vegetation."
			else:
				emit_signal("chest_found")
				return "Behind the gravestone of Thomas Dehler the ground is trodden down and bare of vegetation. You take the spade and ram it into the ground. After some shoveling, you come across something hard and hollow. It is a wooden chest. You carefully uncover it and heave it next to the grave."
		"chest":
			update_status(35, ITEM_STATUS.FOUND)
			return "Printed on the box are some Cyrillic letters next to a caliber designation, which you don't understand. You open the box and search through its contents. You find many old passports with different names, but always the same photo of a young man in his thirties. You also find several military medals and badges. One of them looks familiar to you. It consists of a shield bearing a red star with a hammer and sickle and the letters “КГБ ССССР”. At the bottom you find an old newspaper article."
		"hatch":
			return "There is a commissioning form hanging on the side of the block. The last commissioning was therefore 4 weeks ago. You open the metal hatch. A gust of lukewarm air comes towards you. The incoming light illuminates a small interior space that is 1 meter high and wide, but at least 3 meters long. The interior was built with light-colored stones. You see a lot of ash on the floor, but you can't find anything else."
		"box":
			if status(35) == ITEM_STATUS.INITIAL:
				update_status(35, ITEM_STATUS.FOUND)
				return "Printed on the box are a caliber designation and some Cyrillic letters that you don't understand. You open the box and search through its contents. You find many old passports with different names, but always the same photo of a young man in his thirties. Next to them you find several military medals and badges. One of them looks familiar to you. It consists of a shield with a red star with a hammer and sickle and the letters \"КГБ СССР\". At the very bottom you find an old newspaper article."
			else:
				return "Printed on the box are a caliber designation and some Cyrillic letters that you don't understand. You open the box and search through its contents. You find many old passports with different names, but always the same photo of a young man in his thirties. Next to them you find several military medals and badges. One of them looks familiar to you. It consists of a shield with a red star with a hammer and sickle and the letters \"КГБ СССР\"."
		"car_key":
			return inventory.filter(func(el): return el.identifier == "car_key")[0].description
		"notes_with_code":
			return inventory.filter(func(el): return el.identifier == "notes_with_code")[0].description
		"spare_key":
			return inventory.filter(func(el): return el.identifier == "spare_key")[0].description
		"hammer":
			return inventory.filter(func(el): return el.identifier == "hammer")[0].description
		"letters":
			return "🕆tfkkar cdgjbp. You noted down these strange letters from the back of a photo in the kitchen."
		"notes_with_code_unlocked":
			show_poi("gravestone")
			return "\"Thomas Dehler\" sounds sensible. But where could you find him?"
		"letters_unlocked":
			show_poi("gravestone")
			return "\"Thomas Dehler\" sounds sensible. But where could you find him?"
		"travel_flyer":
			return "The brochure advertises a trip to Havana. On the front (“Flying to the sunny south”) a Latin American couple is dancing. Inside is the underlined number of a local travel agency."
		"mobile_phone":
			return "The phone is a disposable phone with a small antenna. The lettering on the 9 key has almost completely rubbed off. You try to turn it on. The start-up melody sounds tinny, but two pixelated hands touching each other appear on the display and then a PIN request for 4 digits appears."
		"mobile_phone_unlocked":
			# TODO nice to have sms history  Under “Messages” you find some text messages. Take the SMS history.
			# show flower vases for finding replacement key
			show_poi("flower_vases")
			return "You enter the PIN and the cell phone unlocks. Under Photos you find the yellowed school picture of a little girl and another photo of the young woman from the house. The last picture is from a funeral. On a wreath it says “Inna 1979-1999”. Under “Notes” you find a note: “Spare Crematorium flower vases”. You saw some flower vases at the house. Maybe you should check them out again."
		"spade":
			return inventory.filter(func(el): return el.identifier == "spade")[0].description
		"newspaper_article":
			return "The article deals with the bomb attacks on two Moscow apartment buildings on September 13, 1999. A British newspaper reportedly had unpublished evidence that the Russian secret service was involved in the attacks. According to official Russian investigations, the perpetrators were Chechen separatists. The large picture above shows one of the destroyed high-rise buildings shortly after the attack. In the picture below, the then Russian Prime Minister declares war on the Chechen terrorists."
		"flower_vases":
			if status(22) == ITEM_STATUS.INITIAL:
				update_status(22, ITEM_STATUS.FOUND)
				return "You hadn't noticed the flower vases next to the entrance before. You examine them more closely and find a key in the middle one."
			else:
				return "You found a key in these flower vases."
		_:
			return "No text found."

# show previously hidden poi on map
func show_poi(identifier):
	for el in pois:
		if el.identifier == identifier:
			el.hidden = false
			break

# update status of an item
func update_status(id: int, status: ITEM_STATUS):
	var foundId = -1
	for i in range(inventory.size()):
		if inventory[i].id == id:
			foundId = i
			break
	inventory[foundId].status = status
	if status == ITEM_STATUS.FOUND:
		found_identifier = inventory[foundId].identifier
		found_icon = inventory[foundId].icon
	emit_signal("item_found")

# turn identifiers into human readable titles
func getTitleFromIdentifier(identifier: String):
	return identifier.replace("_", " ").capitalize()

# a button of a poi or inventory item is clicked
func click_button(identifier: String):
	var path
	if get_node_or_null("/root/map"): # map or submap
		path = "/root/map/Camera/TextBox"
	else: # inventory
		path = "/root/inventory/TextBox"
	if identifier == "opel": # end of game
		get_tree().change_scene_to_file("res://assets/scenes/end.tscn")
	else:
		get_node(path).setTextBox(getTitleFromIdentifier(identifier), get_text(identifier), getTitleFromIdentifier(found_identifier), found_icon)
		found_identifier = ''
		found_icon = ''

# open the unlock dialoge on an item in the inventory
func click_unlock(identifier: String, solution: String):
	var path = "/root/inventory/UnlockBox"
	get_node(path).setUnlockBox(identifier, solution)
