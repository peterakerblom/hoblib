extends TextureButton

signal book_clicked(genre)

var genre_name: String
#@export var genre_texture: Texture2D  

@onready var genre_icon: TextureRect = $TextureRectIcon

func _ready() -> void:
	var genre_nbr = randi_range(1, Data.genres.size())
	genre_name = Data.genres[genre_nbr]
	var img_path = "res://assets/sprites/icon_" + genre_name + "_32.png"
	var image = Image.load_from_file(img_path)
	var texture: Texture2D = ImageTexture.create_from_image(image)
	
	#if genre_texture:
	if texture:
		genre_icon.texture = texture
	add_to_group("minigame_books")


func _on_pressed() -> void:
	print("genre_name")
	print(genre_name)
	emit_signal("book_clicked", genre_name)
