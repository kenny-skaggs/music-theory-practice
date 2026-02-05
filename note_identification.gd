extends Control

const WideScreenBreakpoint := 800

@onready var staff: Staff = $MarginContainer/BoxContainer/Staff
@onready var treble_cleff: Node2D = $MarginContainer/BoxContainer/treble_cleff
@onready var bass_clef: Node2D = $MarginContainer/BoxContainer/BassClef
@onready var note_selection: NoteSelection = $MarginContainer/BoxContainer/NoteSelection
@onready var background: ColorRect = $background

@onready var box_container: BoxContainer = $MarginContainer/BoxContainer

var note_list := [
	'E2', 'F2', 'G2', 'A2', 'B2', 'C3', 'D3', 'E3', 'F3', 'G3', 'A3', 'B3',
	'C4', 'D4', 'E4', 'F4', 'G4', 'A4', 'B4', 'C5', 'D5', 'E5', 'F5', 'G5', 'A5'
]
var current_note: Note


func _ready() -> void:
	background.color = Common.background_color

	_set_note_position()
	_position_cleffs()

	if not Common.is_mobile_system():
		note_selection.size_flags_vertical = Control.SIZE_SHRINK_BEGIN | Control.SIZE_EXPAND

func _set_note_position() -> void:
	staff.render_note(_select_new_note())

func _position_cleffs() -> void:
	var g4_position = staff.get_note_position(Common.notes_by_name['G4'])
	treble_cleff.position = Vector2(
		staff.position.x,
		staff.position.y + g4_position.y
	)
	var f3_position = staff.get_note_position(Common.notes_by_name['F3'])
	bass_clef.position = Vector2(
		staff.position.x,
		staff.position.y + f3_position.y
	)

func _select_new_note() -> Note:
	var note_name = note_list.pick_random()
	if current_note and note_name == current_note.note_name:
		return _select_new_note()

	current_note = Common.notes_by_name[note_name]
	return current_note

func _on_note_selection_did_select(pitch_class: int) -> void:
	if pitch_class == current_note.pitch_class:
		note_selection.clear_incorrect_answers()
		_set_note_position()
	else:
		note_selection.mark_selection_incorrect(pitch_class)

func _on_resized() -> void:
	if Common.is_mobile_system() and box_container:
		var should_show_narrow_layout := size.x <= WideScreenBreakpoint
		box_container.vertical = should_show_narrow_layout
		note_selection.vertical = not should_show_narrow_layout
		if should_show_narrow_layout:
			note_selection.show_narrow_layout()
		else:
			note_selection.show_wide_layout()

	if treble_cleff:
		_position_cleffs()
