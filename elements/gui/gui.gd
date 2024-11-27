extends CanvasLayer

@onready var inventory_panel: Control = %InventoryPanel
@onready var text_box: TextBox = %TextBox
@onready var poi_label_panel: PanelContainer = %PoiLabelPanel
@onready var unlock_box: CenterContainer = %UnlockBox
@onready var open_inventory: MyButton = %OpenInventory
@onready var items: PanelContainer = %Items
@onready var back_map: MyButton = %BackMap

var discovered_locations = []

func _ready() -> void:
	poi_label_panel.hide()
	text_box.hide()
	inventory_panel.hide()
	unlock_box.hide()
	back_map.hide()

func show_poi_label_panel(name: String, position: Vector2):
	poi_label_panel.visible = true
	poi_label_panel.position = position
	poi_label_panel.set_text(name)

func hide_poi_label_panel():
	poi_label_panel.hide()


func process_interaction(name: String):
	match name:
		"fountain":
			if inventory_panel.get_status("hammer") == Utils.ItemStatus.INITIAL:
				return "It is an old stone fountain with a statue in the middle. It is completely frozen over. Under you can see a fist-sized rectangular object under the ice. You knock against the ice. It is several centimeters thick."
			elif inventory_panel.get_status("hammer") == Utils.ItemStatus.FOUND:
				return {
					"used": "hammer",
					"found": "mobile_phone",
					"text": "You take the hammer in your hand and hit the ice. The ice shatters and cold water splashes in your face. You fish for the object with your other hand and pull it out with numb fingers."
				}
			else:
				return "It is an old stone fountain with a statue in the middle. The water is frozen over. There is a hole in the ice where you broke it with the hammer."
		"police_car":
			if inventory_panel.get_status("hammer") == Utils.ItemStatus.INITIAL:
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
			if inventory_panel.get_status("travel_flyer") == Utils.ItemStatus.INITIAL:
				return {
					"found": "travel_flyer",
					"text": "An old light brown leather sofa with a travel brochure lying on it."
				}
			else:
				return "An old light brown leather sofa."
		"photo": 
			if inventory_panel.get_status("letters") == Utils.ItemStatus.INITIAL:
				return {
					"found": "letters",
					"text": "The photo shows a young woman. She is probably in her early 20s. She has brown hair, is wearing earrings and lipstick. She is smiling confidently into the camera. On the back is handwritten in dark ink “Inna, 1998” and in the bottom right corner is a cross with strange letters that make no sense. You note it down."
				}
			else:
				return "You already examined the photo of the young woman and noted down the strange letters."
		"answering_machine":
			return "You can see a red 5 on the answering machine display. You listen to the messages. The first is from 2 weeks ago, a florist has to cancel a delivery. The second is from a withheld number, no message was left. The third is from the local baker 1 week ago: “Boris, it might be strange, but there were some strange men here just now who asked about you. But they didn’t want to say what for. I just said where they can find you. I hope you don’t get into trouble.” The fourth and fifth are the cemetery manager, a little grumpy at first (3 days ago), then more concerned (2 days ago)."
		"wardrobe":
			if inventory_panel.get_status("notes_with_code") == Utils.ItemStatus.INITIAL:
				return {
					"found": "notes_with_code",
					"text": "An old white wardrobe. You open the doors and find that it is empty except for a few T-shirts. Down on the floor you find a notebook. You leaf through the notebook and find shopping lists, a half-finished letter in Cyrillic and incomprehensible schematic drawings. As you leaf through it, a piece of paper falls out."
				}
			else: 
				return "An old white wardrobe. You open the doors and find that it is empty except for a few T-shirts."
		"bed":
			return "On the metal frame lies a mattress with a checked blanket, pillows and a bedspread with flowers on it. Under the mattress you find a men's magazine called \"Wochenend\". Next to a scantily clad woman are the headlines \"The truth about syphilis is so horrific\", \"Farmer Benno\'s marriage candidate turned out to be a massage girl\" and \"Prostitution: It is so dangerous to make a living from paid love today\". You find nothing else."
		"leaning_spade":
			if inventory_panel.get_status("spade") == Utils.ItemStatus.INITIAL:
				return {
					"found": "spade",
					"text": "The spade still looks to be in good shape. You take it with you as a precaution."
				}
			else:
				return "You picked up the spade here."
		"flower_vases":
			if (inventory_panel.get_status("spare_key") == Utils.ItemStatus.INITIAL):
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
			if inventory_panel.get_status("spare_key") == Utils.ItemStatus.INITIAL:
				return "The gate is about 5 paces wide and made of dark wood with metal fittings. It looks very solid. In the middle you can see a keyhole. You shake it, but it doesn't open."
			else:
				#emit_signal("crematorium_key_found") # TODO change icon for gate
				return {
					"found": "spare_key",
					"text": "The heavy metal key fits perfectly into the gate lock. You turn the key in the lock and open the gate."
				}
		"cart":
			if inventory_panel.get_status("car_key") == Utils.ItemStatus.INITIAL:
				return {
					"found": "car_key",
					"discovered": "opel",
					"text": "The metal carts are made of stainless steel tubes and are 1 meter high with 4 small wheels each. When you try to push one of them to the side, a wheel blocks and you find a car key underneath."
				}
			else:
				return "The metal carts are made of stainless steel tubes and are 1 meter high with 4 small wheels each."
		"mud":
			return "You examine the mud on the ground more closely and can see a footprint. You estimate the shoe size to be at least 43."
		"gravestone":
			if inventory_panel.get_status("spade") == Utils.ItemStatus.INITIAL:
				return "A little way away from the other graves you find the dark gravestone of Thomas Dehler with the dates of his death and a dedication \"And forgive us our sins\". A few smaller sandstone slabs are leaning against the back of the gravestone. You put them to one side and notice that the ground is trodden down and bare of vegetation."
			else:
				#emit_signal("chest_found") # TODO
				return "Behind the gravestone of Thomas Dehler the ground is trodden down and bare of vegetation. You take the spade and ram it into the ground. After some shoveling, you come across something hard and hollow. It is a wooden chest. You carefully uncover it and heave it next to the grave."
		"chest":
			return {
				"found": "newspaper_article",
				"text": "Printed on the box are some Cyrillic letters next to a caliber designation, which you don't understand. You open the box and search through its contents. You find many old passports with different names, but always the same photo of a young man in his thirties. You also find several military medals and badges. One of them looks familiar to you. It consists of a shield bearing a red star with a hammer and sickle and the letters “КГБ ССССР”. At the bottom you find an old newspaper article."
			}
		"hatch":
			return "There is a commissioning form hanging on the side of the block. The last commissioning was therefore 4 weeks ago. You open the metal hatch. A gust of lukewarm air comes towards you. The incoming light illuminates a small interior space that is 1 meter high and wide, but at least 3 meters long. The interior was built with light-colored stones. You see a lot of ash on the floor, but you can't find anything else."
		"box":
			if inventory_panel.get_status("newspaper_article") == Utils.ItemStatus.INITIAL:
				return {
					"found": "newspaper_article",
					"text": "Printed on the box are a caliber designation and some Cyrillic letters that you don't understand. You open the box and search through its contents. You find many old passports with different names, but always the same photo of a young man in his thirties. Next to them you find several military medals and badges. One of them looks familiar to you. It consists of a shield with a red star with a hammer and sickle and the letters \"КГБ СССР\". At the very bottom you find an old newspaper article."
				}
			else:
				return "Printed on the box are a caliber designation and some Cyrillic letters that you don't understand. You open the box and search through its contents. You find many old passports with different names, but always the same photo of a young man in his thirties. Next to them you find several military medals and badges. One of them looks familiar to you. It consists of a shield with a red star with a hammer and sickle and the letters \"КГБ СССР\"."
		"car_key":
			return inventory_panel.get_description("car_key")
		"notes_with_code":
			return inventory_panel.get_description("notes_with_code")
		"spare_key":
			return inventory_panel.get_description("spare_key")
		"hammer":
			return inventory_panel.get_description("hammer")
		"letters":
			return "🕆tfkkar cdgjbp. You noted down these strange letters from the back of a photo in the kitchen."
		"notes_with_code_unlocked":
			return {
				"used": ["letters", "notes_with_code"],
				"discovered": "gravestone",
				"text": "\"Thomas Dehler\" sounds sensible. But where could you find him?"
			}
		"letters_unlocked":
			return {
				"used": ["letters", "notes_with_code"],
				"discovered": "gravestone",
				"text": "\"Thomas Dehler\" sounds sensible. But where could you find him?"
			}
		"travel_flyer":
			return "The brochure advertises a trip to Havana. On the front (“Flying to the sunny south”) a Latin American couple is dancing. Inside is the underlined number of a local travel agency."
		"mobile_phone":
			return "The phone is a disposable phone with a small antenna. The lettering on the 9 key has almost completely rubbed off. You try to turn it on. The start-up melody sounds tinny, but two pixelated hands touching each other appear on the display and then a PIN request for 4 digits appears."
		"mobile_phone_unlocked":
			# TODO nice to have sms history  Under “Messages” you find some text messages. Take the SMS history.
			# show flower vases for finding replacement key
			return {
				"used": "mobile_phone",
				"discovered": "flower_vases", 
				"text": "You enter the PIN and the cell phone unlocks. Under Photos you find the yellowed school picture of a little girl and another photo of the young woman from the house. The last picture is from a funeral. On a wreath it says “Inna 1979-1999”. Under “Notes” you find a note: “Spare Crematorium flower vases”. You saw some flower vases at the house. Maybe you should check them out again."
			}
		"spade":
			return inventory_panel.get_description("spade")
		"newspaper_article":
			return "The article deals with the bomb attacks on two Moscow apartment buildings on September 13, 1999. A British newspaper reportedly had unpublished evidence that the Russian secret service was involved in the attacks. According to official Russian investigations, the perpetrators were Chechen separatists. The large picture above shows one of the destroyed high-rise buildings shortly after the attack. In the picture below, the then Russian Prime Minister declares war on the Chechen terrorists."
		"flower_vases":
			if inventory_panel.get_status("spare_key") == Utils.ItemStatus.INITIAL:
				return {
					"found": "spare_key",
					"text": "You hadn't noticed the flower vases next to the entrance before. You examine them more closely and find a key in the middle one."
				}
			else:
				return "You found a key in these flower vases."
		"house":
			return {
				"map": "house"
			}
		"chapel":
			return {
				"map": "chapel"
			}
		"crematorium":
			return {
				"map": "crematorium"
			}
		_:
			return "No text found."

# clicked poi or item
func click_poi_or_item(name: String):
	var feedback = process_interaction(name)
	var name_formatted = Utils.get_title_from_identifier(name)
	if feedback is Dictionary:
		if feedback.has("map"):
			get_node("/root/World/Stage").change_map(feedback.map)
			return
		if feedback.has("found"):
			inventory_panel.set_status(feedback.found, Utils.ItemStatus.FOUND)
		if feedback.has("used"):
			inventory_panel.set_status(feedback.used, Utils.ItemStatus.USED)
		if feedback.has("discovered"):
			discovered_locations += [feedback.discovered]
			print('discovered ', feedback.discovered) # TODO
		if feedback.has("found"):
			text_box.show_text_box(name_formatted, feedback.text, feedback.found)
		else:
			text_box.show_text_box(name_formatted, feedback.text)
	else:
		text_box.show_text_box(name_formatted, feedback)

func show_unlock_box(identifier, solution):
	unlock_box.show_unlock_box(identifier, solution)

func _on_back_map_pressed() -> void:
	get_node("/root/World/Stage").back_map()

func toggle_back_map(display: bool):
	back_map.visible = display
