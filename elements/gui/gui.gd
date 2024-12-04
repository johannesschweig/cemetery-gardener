extends CanvasLayer

@onready var inventory_panel: Control = %InventoryPanel
@onready var text_box: TextBox = %TextBox
@onready var poi_label_panel: PanelContainer = %PoiLabelPanel
@onready var unlock_box: CenterContainer = %UnlockBox
@onready var open_inventory: MyButton = %OpenInventory
@onready var items: PanelContainer = %Items
@onready var back_map: MyButton = %BackMap

var discovered_locations = []
var switched_locations = []

signal discovered_location
signal switched_location

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
				return tr("FOUNTAIN_INSPECT")
			elif inventory_panel.get_status("hammer") == Utils.ItemStatus.FOUND:
				return {
					"used": "hammer",
					"found": "mobile_phone",
					"text": tr("FOUNTAIN_CRUSHING")
				}
			else:
				return tr("FOUNTAIN_CRUSHED")
		"police_car":
			if inventory_panel.get_status("hammer") == Utils.ItemStatus.INITIAL:
				return {
					"found": "hammer",
					"text": tr("POLICE_CAR_HAMMER")
				}
			else:
				return tr("POLICE_CAR_HAMMER_FOUND")
		"sofa": 
			if inventory_panel.get_status("travel_flyer") == Utils.ItemStatus.INITIAL:
				return {
					"found": "travel_flyer",
					"text": tr("SOFA_FLYER")
				}
			else:
				return tr("SOFA_EMPTY")
		"photo": 
			if inventory_panel.get_status("letters") == Utils.ItemStatus.INITIAL:
				return {
					"found": "letters",
					"text": tr("PHOTO_DETAIL")
				}
			else:
				return tr("PHOTO_SEARCHED")
		"answering_machine":
			return tr("ANSWERING_MACHINE_MESSAGES")
		"wardrobe":
			if inventory_panel.get_status("notes_with_code") == Utils.ItemStatus.INITIAL:
				return {
					"found": "notes_with_code",
					"text": tr("WARDROBE_SEARCH")
				}
			else: 
				return tr("WARDROBE_EMPTY")
		"bed":
			return tr("BED_SEARCH")
		"leaning_spade":
			if inventory_panel.get_status("spade") == Utils.ItemStatus.INITIAL:
				return {
					"found": "spade",
					"text": tr("SPADE_INSPECT")
				}
			else:
				return tr("SPADE_EMPTY")
		"flower_vases":
			if (inventory_panel.get_status("spare_key") == Utils.ItemStatus.INITIAL):
				return {
					"found": "spare_key",
					"text": tr("FLOWER_VASES_INSPECT")
				}
			return tr("FLOWER_VASES_EMPTY")
		"seating":
			return tr("SEATING_INSPECT")
		"stand":
			return tr("STAND_INSPECT")
		"gate_closed":
			if inventory_panel.get_status("spare_key") == Utils.ItemStatus.INITIAL:
				return tr("GATE_INSPECT")
			else:
				return {
					"used": "spare_key",
					"switch": ["gate_closed", "gate_open"],
					"text": tr("GATE_OPENING")
				}
		"gate_open":
			return {
				"map": "crematorium"
			}
		"cart":
			if inventory_panel.get_status("car_key") == Utils.ItemStatus.INITIAL:
				return {
					"found": "car_key",
					"discovered": "opel",
					"text": tr("CART_SEARCH")
				}
			else:
				return tr("CART_EMPTY")
		"mud":
			return tr("MUD_INSPECT")
		"thomas_dehler":
			if inventory_panel.get_status("spade") == Utils.ItemStatus.INITIAL:
				return tr("GRAVE_INSPECT")
			else:
				return {
					"switch": ["chest_placeholder", "chest"],
					"text": tr("GRAVE_DIGGING")
				}
		"chest":
			return {
				"found": "newspaper_article",
				"text": tr("CHEST_INSPECT")
			}
		"hatch":
			return tr("HATCH_INSPECT")
		"car_key":
			return inventory_panel.get_description("car_key")
		"notes_with_code":
			return inventory_panel.get_description("notes_with_code")
		"spare_key":
			return inventory_panel.get_description("spare_key")
		"hammer":
			return inventory_panel.get_description("hammer")
		"letters":
			return tr("LETTERS_INFO")
		"notes_with_code_unlocked":
			return {
				"used": ["letters", "notes_with_code"],
				"discovered": "thomas_dehler",
				"text": tr("THOMAS_HINT")
			}
		"letters_unlocked":
			return {
				"used": ["letters", "notes_with_code"],
				"discovered": "thomas_dehler",
				"text": tr("THOMAS_HINT")
			}
		"travel_flyer":
			return tr("TRAVEL_FLYER_INFO")
		"mobile_phone":
			return tr("MOBILE_PHONE_INFO")
		"mobile_phone_unlocked":
			return {
				"used": "mobile_phone",
				"found": "sms_chat",
				"discovered": "flower_vases", 
				"text": tr("MOBILE_PHONE_UNLOCKING")
			}
		"spade":
			return inventory_panel.get_description("spade")
		"newspaper_article":
			return tr("NEWSPAPER_ARTICLE_INFO")
		"sms_chat":
			return {
				"used": "sms_chat",
				"text": "test",
			}
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
		"opel":
			return {
				"stage": "end"
			}
		_:
			return "No text found."

# clicked poi or item
func click_poi_or_item(name: String):
	var feedback = process_interaction(name)
	var name_formatted = Utils.get_title_from_identifier(name)
	if feedback is Dictionary:
		if feedback.has("stage"):
			get_node("/root/World/Stage").next_stage()
			return
		if feedback.has("map"):
			get_node("/root/World/Stage").change_map(feedback.map)
			return
		if feedback.has("found"):
			inventory_panel.set_status(feedback.found, Utils.ItemStatus.FOUND)
		if feedback.has("used"):
			inventory_panel.set_status(feedback.used, Utils.ItemStatus.USED)
		if feedback.has("switch"):
			switched_locations += [feedback.switch]
			switched_location.emit()
		if feedback.has("discovered"):
			discovered_locations += [feedback.discovered]
			discovered_location.emit()
		if feedback.has("found"):
			text_box.show_text_box_with_found_item(name_formatted, feedback.text, feedback.found)
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
