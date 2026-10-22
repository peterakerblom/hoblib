extends Control

signal book_selected(genre)
signal is_inside_drop_zone

@onready var v_box: VBoxContainer = $MarginContainer2/MarginContainer/VBoxContainer
@onready var shelf_light_source: Node2D = $ShelfLightSource
@onready var drop_zone_area_2d: Area2D = $DropZoneArea2D
@onready var label: Label = $CanvasLayer/Label

#var shelf_book = preload("res://scenes/minigame/shelf_book.tscn")
var shelf_book = preload("res://scenes/minigame/shelf_book_btn.tscn")
var target_genre: String = "dragon"

func _ready() -> void:
	label.visible = false
	#self.connect("is_dropped", Callable(self, "_on_light_source_dropped"))
	shelf_light_source.is_dropped.connect(_on_light_dropped)
	for level in range(4):
		var shelf_container: MarginContainer = MarginContainer.new()
		shelf_container.add_theme_constant_override("margin_top", 5)
		shelf_container.add_theme_constant_override("margin_right", 0)
		shelf_container.add_theme_constant_override("margin_bottom", 15)

		var row_container = HBoxContainer.new()
		row_container.alignment = BoxContainer.ALIGNMENT_BEGIN
		row_container.add_theme_constant_override("separation", 1)	
		shelf_container.add_child(row_container)
		v_box.add_child(shelf_container)
		for book_index in range(8):
			#var new_shelf_book = shelf_book.instantiate()
			var new_shelf_book = shelf_book.instantiate()
			row_container.add_child(new_shelf_book)
	
	for book in get_tree().get_nodes_in_group("minigame_books"):
		book.connect("book_clicked", Callable(self, "_on_book_selected"))

#func _process(_delta: float) -> void:
	#point_light_2d.global_position = get_global_mouse_position()

func _on_book_selected(selected_genre: String):
	if selected_genre == target_genre:
		print("Right book found!")
		emit_signal("book_selected", selected_genre)
		queue_free()
		get_tree().change_scene_to_file("res://scenes/level.tscn")
	else:
		print("Wrong book found!")
		emit_signal("book_selected", selected_genre)
		queue_free()
		get_tree().change_scene_to_file("res://scenes/level.tscn")

#func _on_light_source_dropped(is_droped: bool):
	#print("DROPPED")

func _on_light_dropped(light: Node2D):
	print("LIGHT DROPPED")
	#if is_position_inside_placement_area(light.global_position):
		#print("Lampan placerades inom kapseln!")
		##Minigame.is_in_drop_zone = true
	#else:
		##Minigame.is_in_drop_zone = false
		##print("Utanför området! Återställer lampan.")
		##light.return_to_original_position()
		#label.visible = true
		#var tween = create_tween()
		#tween.tween_interval(4.0)
		#tween.tween_callback(func(): label.visible = false )
		#
	var accepted := is_position_inside_placement_area(
		light.global_position
	)
	print(accepted)
	light.confirm_drop(accepted)

func is_position_inside_placement_area(
		world_position: Vector2
) -> bool:
	var query := PhysicsPointQueryParameters2D.new()
	query.position = world_position
	query.collision_mask = drop_zone_area_2d.collision_layer
	query.collide_with_areas = true
	query.collide_with_bodies = false

	var results := (
		get_world_2d()
		.direct_space_state
		.intersect_point(query)
	)

	for result in results:
		if result["collider"] == drop_zone_area_2d:
			return true
	#print("HEJ2")
	#emit_signal("is_inside_drop_zone")
	return false
