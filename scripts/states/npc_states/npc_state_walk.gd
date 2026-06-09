extends NpcState

var direction := Vector2.ZERO

func enter() -> void:
	state_name = "walk"
	timer = randf_range(1.0, 3.0)

	var directions = [
		Vector2.UP,
		Vector2.DOWN,
		Vector2.LEFT,
		Vector2.RIGHT
	]
	direction = directions.pick_random()

	npc.velocity = direction * npc.speed
	
	match direction:
		Vector2.UP:
			npc.animated_sprite.play("walk_up")
		Vector2.DOWN:
			npc.animated_sprite.play("walk_down")
		Vector2.LEFT:
			npc.animated_sprite.play("walk_left")
		Vector2.RIGHT:
			npc.animated_sprite.play("walk_right")

func exit() -> void:
	pass

func update(_delta) -> void:
	pass

func physics_update(delta) -> void:
	timer -= delta

	npc.velocity = direction * npc.speed

	if timer <= 0:
		npc.change_state(Enums.NpcStateEnum.IDLE)
