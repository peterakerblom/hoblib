extends TextureButton

signal book_clicked(genre)

@export var genre_name: String = "dragons"
@export var genre_texture: Texture2D  

@onready var genre_icon: TextureRect = $TextureRectIcon

func _ready() -> void:
	if genre_texture:
		genre_icon.texture = genre_texture


func _on_pressed() -> void:
	print(genre_name)
	emit_signal("book_clicked", genre_name)
