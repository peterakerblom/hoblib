extends Interactable

var minigame_scene = preload("res://scenes/minigame/books_in_shelf.tscn")
var minigame_instance
@onready var level: Node2D = $"../.."
@onready var main: Node = $"../../.."
@onready var minigame_layer = get_tree().root.get_node("Main/MinigameLayer")
@onready var visitor_spawn_points: Marker2D = $"../../VisitorSpawnPoints"


func interact():
	print("Player is getting warm from the fire")
	print("START MINIGAME")
	#var minigame_scene = minigame.instantiate()
	#get_tree().root.add_child(minigame_scene)
	#get_tree().change_scene_to_file("res://scenes/minigame/books_in_shelf.tscn")
	start_minigame()

func start_minigame():
	level.process_mode = Node.PROCESS_MODE_DISABLED
	level.visible = true
	minigame_instance = minigame_scene.instantiate()
	minigame_instance.minigame_finished.connect(_on_minigame_finished)
	minigame_layer.add_child(minigame_instance)
	#get_tree().root.add_child(minigame_instance)
	#level.add_child(minigame_instance)ww

func _on_minigame_finished(won: bool, selected_genre: String):
	level.process_mode = Node.PROCESS_MODE_INHERIT
	level.visible = true
	if won:
		Data.increse_shire_rep(10)
	else:
		Data.increse_shire_rep(5)
	var visitor: Visitor = get_tree().get_first_node_in_group("npc")
	visitor.book_recieved(visitor_spawn_points.position)
		
