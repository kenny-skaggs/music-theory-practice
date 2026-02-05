@tool
class_name Staff extends Control

@onready var note_display: Node2D = $Note
@onready var ledger_line: ColorRect = $Note/ledger_line
@onready var lines: Node2D = $"lines"

const TopMargin := 0.0

var LineSpacing: float = 20.0
var LineHeight: float = 1.0

var notes_needing_ledger_lines: Array[String] = ['C4', 'E2', 'A5']


func _ready() -> void:
	for i in 11:
		if i == 5:  # skip middle c
			continue

		var line = _build_staff_line()
		line.position = Vector2(0, (i + 1) * LineSpacing + TopMargin)
		lines.add_child(line)

	ledger_line.color = Common.foreground_color
	_center_note_display.call_deferred()

func render_note(note: Note) -> void:
	note_display.position = get_note_position(note)
	note_display.position.y += 1
	note_display.visible = true
	ledger_line.visible = note.note_name in notes_needing_ledger_lines

func get_note_position(note: Note) -> Vector2:
	var top_c2_offset := _get_top_line_offset_from_c2()
	var position_from_top := top_c2_offset - note.offset_from_c2

	return Vector2(
		size.x / 2.0,
		(position_from_top + 2) * LineSpacing / 2.0 + TopMargin
	)

func _get_top_line_offset_from_c2() -> int:
	return 24

func _build_staff_line() -> Control:
	var line := ColorRect.new()
	line.color = Common.foreground_color
	line.size = Vector2(size.x, LineHeight)
	line.mouse_filter = Control.MOUSE_FILTER_IGNORE
	return line

func _on_resized() -> void:
	for line in _get_lines():
		line.size.x = size.x
		#line.position.x = -size.x / 2.0

	if note_display:
		_center_note_display()

func _center_note_display() -> void:
	note_display.position.x = size.x / 2.0

func _get_lines() -> Array[ColorRect]:
	var result: Array[ColorRect]
	if lines:
		result.assign(lines.get_children())
	return result
