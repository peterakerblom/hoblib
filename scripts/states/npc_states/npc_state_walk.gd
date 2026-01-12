extends NpcState

func enter() -> void:
	state_name = "walk"
	npc.velocity = Vector2.ZERO

func exit() -> void:
	pass

func update(_delta) -> void:
	pass

func physics_update(_delta) -> void:
	#var input_dir = Input.get_vector(
		#"left", "right",
		#"up", "down"
	#)
	#
	#if Input.is_action_just_pressed("interact") and player.interactable:
		#player.change_state(Enums.State.INTERACT)

	if npc.velocity == Vector2.ZERO:
		npc.change_state(Enums.NpcStateEnum.IDLE)
