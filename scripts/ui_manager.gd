extends CanvasLayer

var _label: Label

func _ready() -> void:
	layer = 10  

	_label = Label.new()
	_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	_label.add_theme_font_size_override("font_size", 42)
	_label.anchor_left = 0.0
	_label.anchor_right = 1.0
	_label.anchor_top = 0.35
	_label.anchor_bottom = 0.65
	_label.autowrap_mode = TextServer.AUTOWRAP_WORD
	add_child(_label)

func show_message(texto: String) -> void:
	_label.text = texto
