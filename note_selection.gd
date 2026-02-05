class_name NoteSelection extends Control

signal did_select(pitch_class: Common.PitchClass)

const WrongSelectionStyle: StyleBox = preload("res://wrong_answer_style.tres")

@onready var button_container: FlowContainer = $button_container
@onready var c_button: Button = $button_container/c_button
@onready var d_button: Button = $button_container/d_button
@onready var e_button: Button = $button_container/e_button
@onready var f_button: Button = $button_container/f_button
@onready var g_button: Button = $button_container/g_button
@onready var a_button: Button = $button_container/a_button
@onready var b_button: Button = $button_container/b_button


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
	for button in button_container.get_children():
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
