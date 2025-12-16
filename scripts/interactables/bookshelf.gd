extends Interactable


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func interact():
	print("Interacted with bookshelf")
	var player: Player = get_tree().get_first_node_in_group("player")
	if player.inventory.has_item(Book):
		var book: Book = player.inventory.get_item(Book)
		player.inventory.remove_item(book)
		print("Player retuned book to the bookshelf")
	else:
		print("Player has no book")
