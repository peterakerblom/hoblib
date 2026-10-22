extends Node2D

var is_picked_up: bool = false
var original_position: Vector2
var mouse_entered: bool = false
@onready var area_2d: Area2D = $Area2D
signal is_dropped(light: Node2D)
@onready var drop_zone_area_2d: Area2D = $"../DropZoneArea2D"

func _ready() -> void:
	original_position = global_position
	drop_zone_area_2d.input_pickable = true
	#self.connect("is_inside_drop_zone", Callable(self, "_on_is_inside_drop_zone"))
	#pass

#func _on_is_inside_drop_zone():
	#print("HEJ!!!!!!!!!!!!!!!!!")
	#pass
func confirm_drop(accepted: bool) -> void:
	if accepted:
		is_picked_up = false

func _process(_delta: float) -> void:
	if is_picked_up:
		global_position = get_global_mouse_position()

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			_is_clicked()

func _is_clicked() -> void:
	if not is_picked_up:
		# Första klicket: plocka upp lampan.
		is_picked_up = true
	else:
		# Andra klicket: be om att få släppa lampan.
		# Låt is_picked_up vara true tills bokhyllan svarar.
		is_dropped.emit(self)
#func _is_clicked():
	#
	#is_picked_up = not is_picked_up
	#if not is_picked_up:
		#_on_is_dropped()
#
	##if Minigame.is_in_drop_zone and not is_picked_up:
		##_on_is_dropped()
	##else:
		##pass 

func _on_is_dropped() -> void:
	emit_signal("is_dropped", self)
	
func return_to_original_position() -> void:
	is_picked_up = false
	global_position = original_position
