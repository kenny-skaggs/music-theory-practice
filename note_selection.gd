class_name NoteSelection extends FlowContainer

signal did_select(pitch_class: Common.PitchClass)

const WrongSelectionStyle: StyleBox = preload("res://wrong_answer_style.tres")

const MobileButtonSeperation := 40
const DesktopButtonSeperation := 10

@onready var group_1: FlowContainer = $group_1
@onready var group_2: FlowContainer = $group_2

@onready var c_button: Button = $group_1/c_button
@onready var d_button: Button = $group_1/d_button
@onready var e_button: Button = $group_1/e_button
@onready var f_button: Button = $group_2/f_button
@onready var g_button: Button = $group_2/g_button
@onready var a_button: Button = $group_2/a_button
@onready var b_button: Button = $group_2/b_button


func _ready() -> void:
	for container: FlowContainer in [self, group_1, group_2]:
		container.add_theme_constant_override(
			'h_separation',
			MobileButtonSeperation if Common.is_mobile_system() else DesktopButtonSeperation
		)
		container.add_theme_constant_override(
			'v_separation',
			MobileButtonSeperation if Common.is_mobile_system() else DesktopButtonSeperation
		)

func show_narrow_layout() -> void:
	group_1.vertical = true
	group_2.vertical = true

func show_wide_layout() -> void:
	group_1.vertical = false
	group_2.vertical = false

func mark_selection_incorrect(pitch_class: Common.PitchClass) -> void:
	var button: Button
	match pitch_class:
		Common.PitchClass.C:
			button = c_button
		Common.PitchClass.D:
			button = d_button
		Common.PitchClass.E:
			button = e_button
		Common.PitchClass.F:
			button = f_button
		Common.PitchClass.G:
			button = g_button
		Common.PitchClass.A:
			button = a_button
		Common.PitchClass.B:
			button = b_button

	_set_incorrect_style(button)

func clear_incorrect_answers() -> void:
	for button in [
		c_button, d_button, e_button, f_button, g_button, a_button, b_button
	]:
		_clear_style(button)

func _on_button_pressed(pitch_class: Common.PitchClass) -> void:
	did_select.emit(pitch_class)

func _set_incorrect_style(button: Button) -> void:
	button.add_theme_stylebox_override('normal', WrongSelectionStyle)
	button.add_theme_stylebox_override('pressed', WrongSelectionStyle)
	button.add_theme_stylebox_override('hover', WrongSelectionStyle)

func _clear_style(button: Button) -> void:
	button.remove_theme_stylebox_override('normal')
	button.remove_theme_stylebox_override('pressed')
	button.remove_theme_stylebox_override('hover')
