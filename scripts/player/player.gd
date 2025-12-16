extends CharacterBody2D
class_name Player

var speed = 200.0

var current_state: PlayerState
var states:= {}

var interactable: Interactable

@onready var inventory: Inventory = $Inventory

func _ready() -> void:
	$InteractionArea.area_entered.connect(_on_interaction_area_entered)
	$InteractionArea.area_exited.connect(_on_interaction_area_exited)
	states = {
		Enums.State.IDLE: preload("res://scripts/states/player_state_idle.gd").new(),
		Enums.State.WALK: preload("res://scripts/states/player_state_walk.gd").new(),
		Enums.State.INTERACT: preload("res://scripts/states/player_state_interact.gd").new()
	}
	for state in states.values():
		state.player = self
		add_child(state)
	
	change_state(Enums.State.IDLE)

func _physics_process(delta: float) -> void:
	current_state.physics_update(delta)
	move_and_slide()

func _process(delta):
	current_state.update(delta)

func change_state(state):
	if current_state:
		current_state.exit()
	current_state = states[state]
	current_state.enter()
	print("Current state: " + current_state.state_name)



func _on_interaction_area_entered(area: Area2D) -> void:
	if area is Interactable:
		interactable = area


func _on_interaction_area_exited(area: Area2D) -> void:
	if area is Interactable:
		interactable = null
