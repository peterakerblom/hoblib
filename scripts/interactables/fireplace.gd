extends Interactable

var minigame = preload("res://scenes/minigame/books_in_shelf.tscn")


func interact():
	print("Player is getting warm from the fire")
	print("START MINIGAME")
	#var minigame_scene = minigame.instantiate()
	#get_tree().root.add_child(minigame_scene)
	
	get_tree().change_scene_to_file("res://scenes/minigame/books_in_shelf.tscn")
