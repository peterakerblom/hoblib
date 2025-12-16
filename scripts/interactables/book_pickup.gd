extends Interactable

@export var book_resource := preload("res://scripts/items/book.gd")

func interact():
	print("Interacted with Book")
	var book := book_resource.new()
	var player: Player = get_tree().get_first_node_in_group("player")
	player.inventory.add_item(book)
	queue_free()
