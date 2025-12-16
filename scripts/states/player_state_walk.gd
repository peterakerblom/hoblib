extends PlayerState

func enter() -> void:
	state_name = "walk"
	player.velocity = Vector2.ZERO

func exit() -> void:
	pass

func update(_delta) -> void:
	pass

func physics_update(_delta):
	var input_dir = Input.get_vector(
		"left", "right",
		"up", "down"
	)
	
	if Input.is_action_just_pressed("interact") and player.interactable:
		player.change_state(Enums.State.INTERACT)

	elif input_dir == Vector2.ZERO:
		player.change_state(Enums.State.IDLE)
		return

	player.velocity = input_dir * player.speed
