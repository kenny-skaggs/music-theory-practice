extends Node2D

@onready var texture_rect: TextureRect = $TextureRect


func _ready() -> void:
	texture_rect.modulate = Common.foreground_color
