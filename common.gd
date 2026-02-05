extends Node

var note_list: Array[Note]
var notes_by_name: Dictionary[String, Note]

var foreground_color := Color('aeb5bd')
var background_color := Color('17202d')

enum PitchClass {C, D, E, F, G, A, B}
enum StaffType {Treble, Bass, Grand}

func _ready() -> void:
	for octave in [2, 3, 4, 5]:
		var pitch_index := 0
		for pitch_class_str in PitchClass.keys():
			var c2_offset: int = (octave - 2) * 7 + pitch_index
			var note_name := '%s%d' % [pitch_class_str, octave]

			var new_note := Note.new()
			new_note.note_name = note_name
			new_note.offset_from_c2 = c2_offset
			new_note.pitch_class = PitchClass[pitch_class_str]

			note_list.append(new_note)
			notes_by_name[note_name] = new_note

			pitch_index += 1

func is_mobile_system() -> bool:
	return OS.has_feature('web_android') or OS.has_feature('web_ios')
