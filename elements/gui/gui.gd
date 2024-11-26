extends CanvasLayer

#func getLabelText() -> String:
	#var foundItems = GameManager.getNumberOfFoundItems()
	#if foundItems == 0:
		#return "Open Inventory (Empty)"
	#else:
		#return "Open Inventory (%s)" % foundItems
#
#func _ready() -> void:
	#GameManager.item_found.connect(_on_item_found)
	#%OpenInventory.text = getLabelText()
	#%PoiLabelPanel.visible = false
#
#func _on_button_pressed() -> void: # TODO no change in scene pls
	#get_tree().change_scene_to_file("res://elements/mess/inventory.tscn")
#
#func _on_item_found() -> void:
	#%OpenInventory.text = getLabelText()
	
var inventory
var poi_label_panel
var text_box

# TODO duplicate
enum ItemStatus {
	INITIAL,
	FOUND,
	USED
}

func _ready() -> void:
	inventory = %Inventory
	poi_label_panel = %PoiLabelPanel
	text_box = %TextBox
	text_box.visible = false

func show_poi_label_panel(name: String, position: Vector2):
	poi_label_panel.visible = true
	poi_label_panel.position = position
	poi_label_panel.set_text(name)

func hide_poi_label_panel():
	poi_label_panel.visible = false


func process_interaction(name: String):
	match name:
		"fountain":
			if inventory.get_status("hammer") == ItemStatus.INITIAL:
				return "It is an old stone fountain with a statue in the middle. It is completely frozen over. Under you can see a fist-sized rectangular object under the ice. You knock against the ice. It is several centimeters thick."
			elif inventory.get_status("hammer") == ItemStatus.FOUND:
				inventory.set_status("mobile_phone", ItemStatus.FOUND)
				inventory.set_status("hammer", ItemStatus.USED)
				return {
					"found": "mobile_phone",
					"text": "You take the hammer in your hand and hit the ice. The ice shatters and cold water splashes in your face. You fish for the object with your other hand and pull it out with numb fingers."
				}
			else:
				return "It is an old stone fountain with a statue in the middle. The water is frozen over. There is a hole in the ice where you broke it with the hammer."
		"police_car":
			if inventory.get_status("hammer") == ItemStatus.INITIAL:
				inventory.set_status("hammer", ItemStatus.FOUND)
				return {
					"found": "hammer",
					"text": "A VW Golf police car with green stripes on the side. You remember that you still have a hammer in the trunk. Maybe it can still come in handy."
				}
			else:
				return "A VW Golf police car with green stripes on the side. You already looked through your trunk."
		"grave_field":
			return "In the burial ground, graves with gravestones stand in neat rows on the icy meadow."
		"parking_lot":
			return "A normal parking lot paved with gray concrete blocks. Next to your car there are two other cars. No one is sitting in them."
		"sofa": 
			if inventory.get_status("travel_flyer") == ItemStatus.INITIAL:
				inventory.set_status("travel_flyer", ItemStatus.FOUND)
				return {
					"found": "travel_flyer",
					"text": "An old light brown leather sofa with a travel brochure lying on it."
				}
			else:
				return "An old light brown leather sofa."
		"photo": 
			if inventory.get_status("letters") == ItemStatus.INITIAL:
				inventory.set_status("letters", ItemStatus.FOUND)
				return {
					"found": "letters",
					"text": "The photo shows a young woman. She is probably in her early 20s. She has brown hair, is wearing earrings and lipstick. She is smiling confidently into the camera. On the back is handwritten in dark ink “Inna, 1998” and in the bottom right corner is a cross with strange letters that make no sense. You note it down."
				}
			else:
				return "You already examined the photo of the young woman and noted down the strange letters."
		"answering_machine":
			return "You can see a red 5 on the answering machine display. You listen to the messages. The first is from 2 weeks ago, a florist has to cancel a delivery. The second is from a withheld number, no message was left. The third is from the local baker 1 week ago: “Boris, it might be strange, but there were some strange men here just now who asked about you. But they didn’t want to say what for. I just said where they can find you. I hope you don’t get into trouble.” The fourth and fifth are the cemetery manager, a little grumpy at first (3 days ago), then more concerned (2 days ago)."
		"wardrobe":
			if inventory.get_status("notes_with_code") == ItemStatus.INITIAL:
				inventory.set_status("notes_with_code", ItemStatus.FOUND)
				return {
					"found": "notes_with_code",
					"text": "An old white wardrobe. You open the doors and find that it is empty except for a few T-shirts. Down on the floor you find a notebook. You leaf through the notebook and find shopping lists, a half-finished letter in Cyrillic and incomprehensible schematic drawings. As you leaf through it, a piece of paper falls out."
				}
			else: 
				return "An old white wardrobe. You open the doors and find that it is empty except for a few T-shirts."
		"bed":
			return "On the metal frame lies a mattress with a checked blanket, pillows and a bedspread with flowers on it. Under the mattress you find a men's magazine called \"Wochenend\". Next to a scantily clad woman are the headlines \"The truth about syphilis is so horrific\", \"Farmer Benno\'s marriage candidate turned out to be a massage girl\" and \"Prostitution: It is so dangerous to make a living from paid love today\". You find nothing else."
		"leaning_spade":
			if inventory.get_status("spade") == ItemStatus.INITIAL:
				inventory.set_status("spade", ItemStatus.FOUND)
				return {
					"found": "spade",
					"text": "The spade still looks to be in good shape. You take it with you as a precaution."
				}
			else:
				return "You picked up the spade here."
		"flower_vases":
			if (inventory.get_status("spare_key") == ItemStatus.INITIAL):
				inventory.set_status("spare_key", ItemStatus.FOUND)
				return {
					"found": "spare_key",
					"text": "You hadn't even noticed the flower vases next to the entrance before. You examine them and you find a key in the middle one."
				}
			return "You found a key here."
		"seating":
			return "To the left and right there are neat rows of wooden chairs with red cushions. You walk down the rows but don't find anything."
		"stand":
			return "The wooden stand is at the end of the room, along with a few large candle holders. You don't find anything interesting."
		"gate":
			if inventory.get_status("spare_key") == ItemStatus.INITIAL:
				return "The gate is about 5 paces wide and made of dark wood with metal fittings. It looks very solid. In the middle you can see a keyhole. You shake it, but it doesn't open."
			else:
				emit_signal("crematorium_key_found")
				inventory.set_status("spare_key", ItemStatus.USED)
				return "The heavy metal key fits perfectly into the gate lock. You turn the key in the lock and open the gate."
		"carts":
			if inventory.get_status("car_key") == ItemStatus.INITIAL:
				inventory.set_status("car_key", ItemStatus.FOUND)
				# show_poi("opel") # TODO
				return {
					"found": "car_key",
					"text": "The metal carts are made of stainless steel tubes and are 1 meter high with 4 small wheels each. When you try to push one of them to the side, a wheel blocks and you find a car key underneath."
				}
			else:
				return "The metal carts are made of stainless steel tubes and are 1 meter high with 4 small wheels each."
		"mud":
			return "You examine the mud on the ground more closely and can see a footprint. You estimate the shoe size to be at least 43."
		"gravestone":
			if inventory.get_status("spade") == ItemStatus.INITIAL:
				return "A little way away from the other graves you find the dark gravestone of Thomas Dehler with the dates of his death and a dedication \"And forgive us our sins\". A few smaller sandstone slabs are leaning against the back of the gravestone. You put them to one side and notice that the ground is trodden down and bare of vegetation."
			else:
				emit_signal("chest_found")
				return "Behind the gravestone of Thomas Dehler the ground is trodden down and bare of vegetation. You take the spade and ram it into the ground. After some shoveling, you come across something hard and hollow. It is a wooden chest. You carefully uncover it and heave it next to the grave."
		"chest":
			inventory.set_status("newspaper_article", ItemStatus.FOUND)
			return {
				"found": "newspaper_article",
				"text": "Printed on the box are some Cyrillic letters next to a caliber designation, which you don't understand. You open the box and search through its contents. You find many old passports with different names, but always the same photo of a young man in his thirties. You also find several military medals and badges. One of them looks familiar to you. It consists of a shield bearing a red star with a hammer and sickle and the letters “КГБ ССССР”. At the bottom you find an old newspaper article."
			}
		"hatch":
			return "There is a commissioning form hanging on the side of the block. The last commissioning was therefore 4 weeks ago. You open the metal hatch. A gust of lukewarm air comes towards you. The incoming light illuminates a small interior space that is 1 meter high and wide, but at least 3 meters long. The interior was built with light-colored stones. You see a lot of ash on the floor, but you can't find anything else."
		"box":
			if inventory.get_status("newspaper_article") == ItemStatus.INITIAL:
				inventory.set_status("newspaper_article", ItemStatus.FOUND)
				return {
					"found": "newspaper_article",
					"text": "Printed on the box are a caliber designation and some Cyrillic letters that you don't understand. You open the box and search through its contents. You find many old passports with different names, but always the same photo of a young man in his thirties. Next to them you find several military medals and badges. One of them looks familiar to you. It consists of a shield with a red star with a hammer and sickle and the letters \"КГБ СССР\". At the very bottom you find an old newspaper article."
				}
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
			#show_poi("gravestone") # TODO
			return "\"Thomas Dehler\" sounds sensible. But where could you find him?"
		"letters_unlocked":
			#show_poi("gravestone") # TODO
			inventory.set_status("letters", ItemStatus.USED)
			inventory.set_status("notes_with_code", ItemStatus.USED)
			return "\"Thomas Dehler\" sounds sensible. But where could you find him?"
		"travel_flyer":
			return "The brochure advertises a trip to Havana. On the front (“Flying to the sunny south”) a Latin American couple is dancing. Inside is the underlined number of a local travel agency."
		"mobile_phone":
			return "The phone is a disposable phone with a small antenna. The lettering on the 9 key has almost completely rubbed off. You try to turn it on. The start-up melody sounds tinny, but two pixelated hands touching each other appear on the display and then a PIN request for 4 digits appears."
		"mobile_phone_unlocked":
			# TODO nice to have sms history  Under “Messages” you find some text messages. Take the SMS history.
			# show flower vases for finding replacement key
			# show_poi("flower_vases") # TODO
			inventory.set_status("mobile_phone", ItemStatus.USED)
			return "You enter the PIN and the cell phone unlocks. Under Photos you find the yellowed school picture of a little girl and another photo of the young woman from the house. The last picture is from a funeral. On a wreath it says “Inna 1979-1999”. Under “Notes” you find a note: “Spare Crematorium flower vases”. You saw some flower vases at the house. Maybe you should check them out again."
		"spade":
			return inventory.filter(func(el): return el.identifier == "spade")[0].description
		"newspaper_article":
			return "The article deals with the bomb attacks on two Moscow apartment buildings on September 13, 1999. A British newspaper reportedly had unpublished evidence that the Russian secret service was involved in the attacks. According to official Russian investigations, the perpetrators were Chechen separatists. The large picture above shows one of the destroyed high-rise buildings shortly after the attack. In the picture below, the then Russian Prime Minister declares war on the Chechen terrorists."
		"flower_vases":
			if inventory.get_status("spare_key") == ItemStatus.INITIAL:
				inventory.set_status("spare_key", ItemStatus.FOUND)
				return {
					"found": "spare_key",
					"text": "You hadn't noticed the flower vases next to the entrance before. You examine them more closely and find a key in the middle one."
				}
			else:
				return "You found a key in these flower vases."
		_:
			return "No text found."

# clicked poi
func click_poi(name: String):
	var feedback = process_interaction(name)
	var name_formatted = Utils.get_title_from_identifier(name)
	if feedback is Dictionary:
		text_box.show_text_box(name_formatted, feedback.text, feedback.found)
	else:
		text_box.show_text_box(name_formatted, feedback)
