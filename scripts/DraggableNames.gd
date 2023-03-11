extends Label

@onready var Owner := get_parent().get_parent().get_parent()

func _get_drag_data(_at_position):
	Owner.LastNode = self.get_path()
#	print(str(self.name) + " get")
	return self.text

func _can_drop_data(at_position, data):
	return true

func _drop_data(_at_position, data):
	get_node(Owner.LastNode).text = text
#	print(str(self.name) + " drop")
	text = data
