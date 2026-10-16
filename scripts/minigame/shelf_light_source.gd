extends Node2D

var is_picked_up: bool = false
var mouse_entered: bool = false
signal is_droped
@onready var area_2d: Area2D = $Area2D

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	if is_picked_up:
		global_position = get_global_mouse_position()

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			_is_clicked()

func _is_clicked():
	is_picked_up = not is_picked_up
	if not is_picked_up:
		_on_is_droped()

func _on_is_droped() -> void:
	emit_signal("is_droped", true)
