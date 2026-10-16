extends Control

signal book_selected(genre)

@onready var v_box: VBoxContainer = $MarginContainer2/MarginContainer/VBoxContainer
@onready var shelf_light_source: Node2D = $ShelfLightSource

#var shelf_book = preload("res://scenes/minigame/shelf_book.tscn")
var shelf_book = preload("res://scenes/minigame/shelf_book_btn.tscn")
var target_genre: String = "dragon"

func _ready() -> void:
	self.connect("is_droped", Callable(self, "_on_light_source_droped"))
	for level in range(4):
		var shelf_container: MarginContainer = MarginContainer.new()
		shelf_container.add_theme_constant_override("margin_top", 5)
		shelf_container.add_theme_constant_override("margin_right", 0)
		shelf_container.add_theme_constant_override("margin_bottom", 15)

		var row_container = HBoxContainer.new()
		row_container.alignment = BoxContainer.ALIGNMENT_BEGIN
		row_container.add_theme_constant_override("separation", 1)	
		shelf_container.add_child(row_container)
		v_box.add_child(shelf_container)
		for book_index in range(8):
			#var new_shelf_book = shelf_book.instantiate()
			var new_shelf_book = shelf_book.instantiate()
			row_container.add_child(new_shelf_book)
	
	for book in get_tree().get_nodes_in_group("minigame_books"):
		book.connect("book_clicked", Callable(self, "_on_book_selected"))

#func _process(_delta: float) -> void:
	#point_light_2d.global_position = get_global_mouse_position()

func _on_book_selected(selected_genre: String):
	if selected_genre == target_genre:
		print("Right book found!")
		emit_signal("book_selected", selected_genre)
		queue_free()
		get_tree().change_scene_to_file("res://scenes/level.tscn")
	else:
		print("Wrong book found!")
		emit_signal("book_selected", selected_genre)
		queue_free()
		get_tree().change_scene_to_file("res://scenes/level.tscn")

func _on_light_source_droped(is_droped: bool):
	print("DROPED")
