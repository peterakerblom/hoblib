extends Control

signal book_selected(genre)
# var minigame = preload("res://scenes/level.tscn")

var target_genre: String = "dragons"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
