extends PlayerState



func enter() -> void:
	state_name = "idle"
	player.velocity = Vector2.ZERO
	player.animated_sprite.play("idle")

func exit() -> void:
	pass

func update(_delta) -> void:
	pass

func physics_update(_delta) -> void:
	var target = player.get_interactable()
	var input_dir = Input.get_vector(
		"left", "right",
		"up", "down"
	)
	
	if Input.is_action_just_pressed("interact") and target:
		player.change_state(Enums.State.INTERACT)

	elif input_dir != Vector2.ZERO:
		player.change_state(Enums.State.WALK)
