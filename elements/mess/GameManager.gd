extends Node2D

signal crematorium_key_found()
signal chest_found()
signal item_found()

# show all items, hide title screen
@export var debug = false
# for inventory back switching
@export var current_area = "map" # TODO remove

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
