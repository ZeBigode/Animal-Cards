extends HBoxContainer

var selected_child = null

func _ready():
	for i in range(get_child_count()):
		var child = get_child(i)
		child.connect("input_event", self, "_on_TextureRect_input_event")

func _on_TextureRect_input_event(viewport, event, shape_idx):
	var child = event.get_current_scene().get_node(shape_idx)
	if event is InputEventScreenTouch and event.is_pressed() and event.index == 0:
		selected_child = child
		child.raise()
	elif event is InputEventScreenTouch and not event.is_pressed() and event.index == 0 and selected_child == child:
		selected_child = null
	elif event is InputEventScreenDrag and selected_child == child:
		var global_touch_position = event.position
		var new_rect_position = global_touch_position - get_global_position() - child.rect_size / 2
		child.rect_position = new_rect_position
		if child.get_index() > 0 and child.rect_position.x < get_child(child.get_index()-1).rect_position.x:
			$".".swap_children(child, get_child(child.get_index()-1))
		elif child.get_index() < get_child_count()-1 and child.rect_position.x > get_child(child.get_index()+1).rect_position.x:
			$".".swap_children(child, get_child(child.get_index()+1))
