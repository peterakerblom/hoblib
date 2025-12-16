extends PlayerState

func enter() -> void:
	state_name = "interact"
	player.velocity = Vector2.ZERO
	player.interactable.interact()

func exit() -> void:
	pass

func update(_delta) -> void:
	pass

func physics_update(_delta) -> void:
	player.change_state(Enums.State.IDLE)
