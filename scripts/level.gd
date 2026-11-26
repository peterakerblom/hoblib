extends Node2D

@onready var visitor_spawn_points: Marker2D = $VisitorSpawnPoints
@onready var visitor_move_to_points: Marker2D = $VisitorMoveToPoints
@onready var visitor_spawn_timer: Timer = $VisitorSpawnTimer
var visitor = preload("res://scenes/npc/visitor.tscn")
@onready var npcs: Node2D = $npcs
@onready var shire_rep: Label = $UILayer/ShireRep

var minigame_scene = preload("res://scenes/minigame/books_in_shelf.tscn")
var minigame_instance

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visitor_spawn_timer.timeout.connect(_on_timer_timeout)
	Data.shire_rep_changed.connect(_on_shire_rep_changed)
	_on_shire_rep_changed()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_timer_timeout():
	var new_visitor: CharacterBody2D = visitor.instantiate()
	new_visitor.global_position = visitor_spawn_points.global_position
	npcs.add_child(new_visitor)
	new_visitor.set_destination(visitor_move_to_points.global_position)

func _on_shire_rep_changed():
	shire_rep.text = ("Current rep in shire: %s" % Data.shire_rep)
