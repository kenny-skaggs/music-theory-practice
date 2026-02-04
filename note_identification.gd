extends Control

@onready var staff: Staff = $Staff
@onready var treble_cleff: Node2D = $treble_cleff
@onready var bass_clef: Node2D = $BassClef
@onready var note_selection: NoteSelection = $NoteSelection
@onready var background: ColorRect = $background

var note_list := ['C4', 'D4', 'E4', 'F4', 'G4', 'A4', 'B4', 'C5', 'D5', 'E5', 'F5', 'G5', 'A5']
var current_note: Note


func _ready() -> void:
	background.color = Common.background_color

	_set_note_position()

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

func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed('primary_interact'):
		_set_note_position()

func _set_note_position() -> void:
	staff.render_note(_select_new_note())

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
