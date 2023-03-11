extends Label

var dragging = false

func _on_label_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		dragging = true
#		set_drag_preview(get_texture().get_data())

func _on_label_gui_input_event(event):
	if dragging:
#		set_drag_data("label_index", get_index())
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _on_input_event(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.pressed and event.get_drag_data():
		var drag_data = event.get_drag_data()
		var label_index = drag_data.get_data()
		var target_index = get_index()
		if label_index != target_index:
			get_parent().move_child(get_node(str(label_index)), target_index)
		dragging = false
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
