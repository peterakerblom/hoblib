extends Control

signal book_selected(genre)

@onready var v_box: VBoxContainer = $MarginContainer2/MarginContainer/VBoxContainer
var shelf_book = preload("res://scenes/minigame/shelf_book.tscn")
var target_genre: String = "dragon"

func _ready() -> void:
	for level in range(4):
		var shelf_container: MarginContainer = MarginContainer.new()
		shelf_container.add_theme_constant_override("margin_top", 20)
		shelf_container.add_theme_constant_override("margin_right", 0)
		shelf_container.add_theme_constant_override("margin_bottom", 0)

		var row_container = HBoxContainer.new()
		
		shelf_container.add_child(row_container)
		v_box.add_child(shelf_container)
		for book_index in range(5):
			var shelf_book = shelf_book.instantiate()
			row_container.add_child(shelf_book)
	
	for book in get_tree().get_nodes_in_group("minigame_books"):
		book.connect("book_clicked", Callable(self, "_on_book_selected"))

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
