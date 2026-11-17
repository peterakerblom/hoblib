extends CharacterBody2D
class_name Visitor

var speed = 20.0

var current_state: NpcState
var states:= {}
var wished_genre
var interactable: Interactable

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var inventory: Inventory = $Inventory
var destination: Vector2
@onready var talk_bubble: Sprite2D = $TalkBubbleSprite2D
@onready var icon: TextureRect = $TextureRectIcon

func _ready() -> void:
	$InteractionArea.area_entered.connect(_on_interaction_area_entered)
	$InteractionArea.area_exited.connect(_on_interaction_area_exited)
	states = {
		Enums.NpcStateEnum.IDLE: preload("res://scripts/states/npc_states/npc_state_idle.gd").new(),
		Enums.NpcStateEnum.WALK: preload("res://scripts/states/npc_states/npc_state_walk.gd").new(),
		Enums.NpcStateEnum.WALK_TO_COUNTER: preload("res://scripts/states/npc_states/npc_state_walk_to_counter.gd").new(),
		Enums.NpcStateEnum.IDLE_GENRE_REQUEST: preload("res://scripts/states/npc_states/npc_state_idle_genre_request.gd").new(),
	}
	for state in states.values():
		state.npc = self
		add_child(state)
	
	#change_state(Enums.NpcStateEnum.IDLE)
	change_state(Enums.NpcStateEnum.WALK_TO_COUNTER)

func _physics_process(delta: float) -> void:
	pass
	current_state.physics_update(delta)
	move_and_slide()
	


func _process(delta):
	current_state.update(delta)

func change_state(state):
	if current_state:
		current_state.exit()
	current_state = states[state]
	current_state.enter()
	print("Visitor current state: " + current_state.state_name)

func set_destination(position: Vector2):
	destination = position

func _on_interaction_area_entered(area: Area2D) -> void:
	if area is Interactable:
		interactable = area


func _on_interaction_area_exited(area: Area2D) -> void:
	if area is Interactable:
		interactable = null
