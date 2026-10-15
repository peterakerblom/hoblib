#extends Button
extends TextureButton

signal book_clicked(genre)
var genre_name: String
#@export var genre_texture: Texture2D  
@onready var texture_rect: TextureRect = $TextureRect


func _ready() -> void:
	#set_size(Vector2(10, 10))
	#set_custom_minimum_size(Vector2(randi_range(25, 40), randi_range(70, 120)))
	set_custom_minimum_size(Vector2(30, 100))
	#set_custom_maximum_size(Vector2(randi_range(25, 40), randi_range(70, 120)))
	set_custom_maximum_size(Vector2(30, 100))
	var genre_nbr = randi_range(1, Data.genres.size())
	genre_name = Data.genres[genre_nbr]
	var img_path = "res://assets/sprites/icon_" + genre_name + "_32.png"
	var image = Image.load_from_file(img_path)
	var texture: Texture2D = ImageTexture.create_from_image(image)
	
	if texture:
		texture_rect.texture = texture

	add_to_group("minigame_books")


#func _on_pressed() -> void:
	#print("genre_name")
	#print(genre_name)
	#emit_signal("book_clicked", genre_name)


func _on_pressed() -> void:
	print("genre_name")
	print(genre_name)
	emit_signal("book_clicked", genre_name)
