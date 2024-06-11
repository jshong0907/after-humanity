extends VBoxContainer

@onready
var encounter_image = get_node("%EncounterImage")

@onready
var encounter_choices = get_node("%EncounterChoices")

@onready
var json: Array = _load_json()

@onready
var encounter = _select_encounter()

func _load_json() -> Array:
	var file: String = "resources/data/encounter_info.json"
	var json_as_dict: Array = JSON.parse_string(FileAccess.get_file_as_string(file))
	return json_as_dict
	
func _select_encounter() -> Dictionary:
	return json[randi() % json.size()]
	
func _parse_image(obj: Dictionary) -> String:
	return obj["image"]
	
func _parse_choices(obj: Dictionary) -> Array:
	return obj["choices"]

func _change_ability(type: String, amount: int):
	var ability_mapper: Dictionary = {
		"strength": Abilities.modify_strength,
		"speed": Abilities.modify_speed,
	}
	return ability_mapper[type].call(amount)

func _ready():
	var new_texture = load(_parse_image(encounter))
	encounter_image.texture = new_texture
	
	var choices = _parse_choices(encounter)
	for choice in choices:
		var text = choice["text"]
		var type = choice["result"]["type"]
		var amount = int(choice["result"]["amount"])
		var button = Button.new()
		button.text = text
		button.pressed.connect(_change_ability.bind(type, amount))
		
		encounter_choices.add_child(button)

func _process(delta):
	pass
