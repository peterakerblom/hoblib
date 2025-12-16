extends PlayerState

func enter() -> void:
	state_name = "idle"
	player.velocity = Vector2.ZERO

func exit() -> void:
	pass

func update(_delta) -> void:
	pass

func physics_update(_delta) -> void:
	var input_dir = Input.get_vector(
		"ui_left", "ui_right",
		"ui_up", "ui_down"
	)

	if input_dir != Vector2.ZERO:
		player.change_state(Enums.State.WALK)
