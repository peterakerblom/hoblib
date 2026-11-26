extends NpcState

#var texture

func enter() -> void:
	state_name = "idle_genre_request"
	npc.velocity = Vector2.ZERO
	npc.animated_sprite.play("idle")

	var genre_nbr = randi_range(1, Data.genres.size())
	var genre_name = Data.genres[genre_nbr]
	npc.wished_genre = genre_name
	Minigame.target_genre = genre_name
	var img_path = "res://assets/sprites/icon_" + genre_name + "_32.png"
	var image = Image.load_from_file(img_path)
	var texture: Texture2D = ImageTexture.create_from_image(image)
	print(texture)
	npc.icon.texture = texture

	
	timer = randf_range(1.0, 2.0)

func exit() -> void:
	npc.talk_bubble.visible = false
	npc.icon.texture = null
	pass

func update(_delta) -> void:
	pass

func physics_update(delta) -> void:
	timer -= delta

	if timer <= 0:
		npc.talk_bubble.visible = true
		npc.icon.visible = true
		#npc.change_state(Enums.NpcStateEnum.WALK)
