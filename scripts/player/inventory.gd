extends Node
class_name Inventory

var items: Array[Item] = []

func add_item(item: Item):
	items.append(item)

func remove_item(item: Item):
	items.erase(item)

func has_item(type: Script) -> bool:
	for item in items:
		if item.get_script() == type:
			return true
	return false

func get_item(type: Script) -> Item:
	for item in items:
		if item.get_script() == type:
			return item
	return null
