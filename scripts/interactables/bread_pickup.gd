extends Interactable

@export var bread_resource := preload("res://scripts/items/bread.gd")

func interact():
	print("Interacted with Bread")
	var bread := bread_resource.new()
	var player: Player = get_tree().get_first_node_in_group("player")
	player.inventory.add_item(bread)
	queue_free()
