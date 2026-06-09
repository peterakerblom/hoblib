extends NpcState

func enter() -> void:
	state_name = "idle"
	npc.velocity = Vector2.ZERO
	npc.animated_sprite.play("idle")
	
	timer = randf_range(2.0, 5.0)

func exit() -> void:
	pass

func update(_delta) -> void:
	pass

func physics_update(delta) -> void:
	timer -= delta

	if timer <= 0:
		npc.change_state(Enums.NpcStateEnum.WALK)
