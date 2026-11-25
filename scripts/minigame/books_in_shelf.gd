extends Control

signal book_selected(genre)

@onready var v_box: VBoxContainer = $MarginContainer2/MarginContainer/VBoxContainer
@onready var shelf_light_source: Node2D = $ShelfLightSource
@onready var drop_zone_area_2d: Area2D = $DropZoneArea2D
@onready var label: Label = $CanvasLayer/Label
@onready var canvas_modulate: CanvasModulate = $CanvasModulate
@onready var animation_layer: Control = $AnimationLayer
@onready var minigame_canvas: CanvasLayer = get_parent() as CanvasLayer

var shelf_book = preload("res://scenes/minigame/shelf_book_btn.tscn")
#var target_genre: String = "dragon"
var target_genre: String = Minigame.target_genre
var selected_book: TextureButton

func _ready() -> void:
	label.visible = false
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
			var new_shelf_book = shelf_book.instantiate()
			row_container.add_child(new_shelf_book)
	
	for book in get_tree().get_nodes_in_group("minigame_books"):
		book.connect("book_clicked", Callable(self, "_on_book_selected"))

func _on_book_selected(selected_genre: String, book):
	selected_book = book
	#var org_pos: Vector2 = selected_book.position
	var org_pos: Vector2 = selected_book.global_position
	var org_scale: Vector2 = selected_book.scale
	var org_pivot: Vector2 = selected_book.pivot_offset
	var org_canvas_color = canvas_modulate.color
	
	selected_book.reparent(animation_layer, true)
	
	# Gör så att boken växer runt sin mittpunkt
	selected_book.pivot_offset = selected_book.size / 2.0
	
	# Beräkna mitten av skärmen
	#var target_position: Vector2 = (
		#get_viewport_rect().size - selected_book.size
	#) / 2.0
	var target_position := (animation_layer.size - selected_book.size) / 2.0
	
	var book_tween := create_tween()
	book_tween.set_trans(Tween.TRANS_CUBIC)
	book_tween.set_ease(Tween.EASE_IN_OUT)
	#book_tween.tween_property(selected_book, "scale", Vector2(2, 2), 2)
	#book_tween.tween_property(selected_book, "top_level", true, 2)
	#book_tween.tween_callback(selected_book.bind(Color.RED)).set_delay(2)
	#book_tween.tween_callback(selected_book.bind(Color.BLUE)).set_delay(2)
	# DEL 1: Boken växer och rör sig mot mitten.
	book_tween.tween_property(
		book,
		"position",
		target_position,
		2.0
	)
	book_tween.parallel().tween_property(
		book,
		"scale",
		org_scale * 1.8,
		2.0
	)
	# Samtidigt försvinner CanvasModulates färgfilter.
	book_tween.parallel().tween_property(
		canvas_modulate,
		"color",
		Color.WHITE,
		1
	)
	## DEL 2: Boken återgår till sin ursprungliga position.
	#book_tween.tween_property(
		#book,
		#"position",
		#org_pos,
		#2.0
	#)
	# Den globala positionen konverteras till animationslagrets koordinater.
	#var return_position = animation_layer.to_local(org_pos)
	var return_position: Vector2 = (
		animation_layer.get_global_transform_with_canvas().affine_inverse()
		* selected_book.get_global_transform_with_canvas().origin
	)
	#return_position.y = return_position.y + 500
	return_position.y = target_position.y + 500
	return_position.x = target_position.x
	book_tween.tween_property(
		book,
		"position",
		return_position,
		1
	)

	book_tween.parallel().tween_property(
		book,
		"scale",
		org_scale,
		1
	)
	book_tween.parallel().tween_property(
		canvas_modulate,
		"color",
		org_canvas_color,
		1
	)

	## Återställ pivot när animationen är klar.
	#book_tween.tween_callback(
		#func():
			#selected_book.pivot_offset = org_pivot
	#)

	# DEL 3: Vänta tills hela sekvensen är klar.
	await book_tween.finished

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

func _on_light_dropped(light: Node2D):
	var accepted := is_position_inside_placement_area(
		light.global_position
	)
	light.confirm_drop(accepted)

func is_position_inside_placement_area(
		world_position: Vector2
) -> bool:
	#var query := PhysicsPointQueryParameters2D.new()
	#query.position = world_position
	#query.collision_mask = drop_zone_area_2d.collision_layer
	#query.collide_with_areas = true
	#query.collide_with_bodies = false
	#var results := (
		#get_world_2d()
		#.direct_space_state
		#.intersect_point(query)
	#)
	#for result in results:
		#if result["collider"] == drop_zone_area_2d:
			#return true
	#label.visible = true
	#var tween = create_tween()
	#tween.tween_interval(4.0)
	#tween.tween_callback(func(): label.visible = false )
	#return false

	var query := PhysicsPointQueryParameters2D.new()

	query.position = world_position
	query.collision_mask = drop_zone_area_2d.collision_layer
	query.collide_with_areas = true
	query.collide_with_bodies = false

	query.canvas_instance_id = minigame_canvas.get_instance_id()

	var results = get_world_2d().direct_space_state.intersect_point(query)

	for result in results:
		if result["collider"] == drop_zone_area_2d:
			return true

	label.visible = true
	return false
