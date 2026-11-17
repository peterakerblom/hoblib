extends NpcState

var direction: Vector2
var facing: String = "up"

func enter() -> void:
	state_name = "walk_to_counter"

		
	#match npc.velocity:
		#Vector2.UP:
			#npc.animated_sprite.play("walk_up")
		#Vector2.DOWN:
			#npc.animated_sprite.play("walk_down")
		#Vector2.LEFT:
			#npc.animated_sprite.play("walk_left")
		#Vector2.RIGHT:
			#npc.animated_sprite.play("walk_right")

func exit() -> void:
	pass

func update(_delta) -> void:
	#print(npc.velocity)
	#if npc.velocity.y < 0:
		#var new_facing = "up"
		#if facing != new_facing:
			#npc.animated_sprite.play("walk_up")
	#elif npc.velocity.y > 0:
		#var new_facing = "down"
		#if facing != new_facing:
			#npc.animated_sprite.play("walk_down")
	#if npc.velocity.x < 0:
		#var new_facing = "left"
		#if facing != new_facing:
			#npc.animated_sprite.play("walk_left")
	#elif npc.velocity.x > 0:
		#var new_facing = "right"
		#if facing != new_facing:
			#npc.animated_sprite.play("walk_right")


	var angle = atan2(npc.velocity.y, npc.velocity.x) # angle in [-PI, PI]

	if abs(angle) < 0.25 * PI:
		npc.animated_sprite.play("walk_right")
	elif abs(angle) > 0.75 * PI:
		npc.animated_sprite.play("walk_left")
	elif angle < 0.0:
		npc.animated_sprite.play("walk_up")
	else:
		npc.animated_sprite.play("walk_down")


func physics_update(delta) -> void:
	if npc.global_position.distance_to(npc.destination) <= 5.0:
		npc.change_state(Enums.NpcStateEnum.IDLE_GENRE_REQUEST)
		return

	var direction = npc.global_position.direction_to(npc.destination)
	npc.velocity = direction * npc.speed
	#npc.move_and_slide()
