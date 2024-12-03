class_name TextBox extends CenterContainer

@onready var titleLabel: Label = %Title
@onready var description: RichTextLabel = %Description

@onready var additional_info: HBoxContainer = %AdditionalInfo
@onready var additional_icon: TextureRect = %AdditionalIcon
@onready var additional_name: RichTextLabel = %AdditionalName


func show_text_box(title: String, text: String):
	titleLabel.text = title
	description.text = text
	additional_info.visible = false
	self.visible = true

func show_text_box_with_found_item(title: String, text: String, found_identifier: String):
	titleLabel.text = title
	description.text = text
	
	additional_name.text = Utils.get_title_from_identifier(found_identifier) + " " + tr("FOUND")
	additional_icon.texture = load("res://assets/items/" + found_identifier + ".png")
	additional_info.visible = true
	self.visible = true

func _on_button_pressed() -> void:
	self.visible = false
