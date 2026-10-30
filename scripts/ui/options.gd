extends Control

@onready var button_exit: Button = $VBoxContainer/ButtonExit
@onready var main_menu_str = "res://scenes/ui/main_menu.tscn"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_back_pressed() -> void:
	get_tree().change_scene_to_file(main_menu_str)


func _on_check_button_fullscreens_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
