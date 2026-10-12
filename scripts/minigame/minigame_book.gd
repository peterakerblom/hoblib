extends TextureButton

signal book_clicked(genre)

@export var genre_name: String = "dragons"
@export var genre_texture: Texture2D  
# Create instance of a scene.

#var image = Image.load_from_file("res://assets/sprites/icon_dragon_32.png")
#var texture = ImageTexture.create_from_image(image)

@onready var genre_icon: TextureRect = $TextureRectIcon

func _ready() -> void:
	var genre_nbr = randi_range(1, 2)
	var genre = Data.genres[genre_nbr]
	print("GENRE", genre)
	#var img_path = "res://assets/sprites/icon_{0}_32.png".format(["{0}", genre])
	var img_path = "res://assets/sprites/icon_" + genre + "_32.png"
	print(img_path)
	var image = Image.load_from_file("res://assets/sprites/icon_{genre}_32.png")
	print(image)
	var texture = ImageTexture.create_from_image(image)
	print(texture)
	
	#if genre_texture:
	if texture:
		print("YES")
		genre_icon.texture = texture
	add_to_group("minigame_books")


func _on_pressed() -> void:
	print(genre_name)
	emit_signal("book_clicked", genre_name)
