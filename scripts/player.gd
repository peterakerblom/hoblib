extends CharacterBody2D


var speed = 200.0

var current_state: PlayerState
var states:= {}

func _ready() -> void:
	states = {
		Enums.State.IDLE: preload("res://scripts/states/player_state_idle.gd").new(),
		Enums.State.WALK: preload("res://scripts/states/player_state_walk.gd").new()
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
	print("Current state: " + current_state.name)
