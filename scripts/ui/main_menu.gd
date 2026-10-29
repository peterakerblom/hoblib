extends Control

@onready var button_play: Button = $VBoxContainer/ButtonPlay
@onready var button_options: Button = $VBoxContainer/ButtonOptions
@onready var button_exit: Button = $VBoxContainer/ButtonExit
@onready var level_str = "res://scenes/level.tscn"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button_play.pressed.connect(_on_button_play_pressed.bind(button_play))
	button_options.pressed.connect(_on_button_options_pressed.bind(button_options))
	button_exit.pressed.connect(_on_button_exit_pressed.bind(button_exit))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_play_pressed() -> void:
	get_tree().change_scene_to_file(level_str)
	queue_free()
	pass # Replace with function body.


func _on_button_options_pressed() -> void:
	pass # Replace with function body.


func _on_button_exit_pressed() -> void:
	get_tree().quit()
