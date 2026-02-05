@tool
class_name SelectionButton extends Button

signal did_select(pitch_class: Common.PitchClass)

@export var pitch_class: Common.PitchClass:
	get:
		return pitch_class
	set(value):
		pitch_class = value
		text = Common.PitchClass.keys()[pitch_class]

func _ready() -> void:
	text = Common.PitchClass.keys()[pitch_class]
	pressed.connect(_on_pressed)

	if not Common.is_mobile_system():
		custom_minimum_size = Vector2(40, 40)

func _on_pressed() -> void:
	did_select.emit(pitch_class)
