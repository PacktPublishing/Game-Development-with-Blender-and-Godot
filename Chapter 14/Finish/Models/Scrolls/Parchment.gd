extends Spatial

signal show_note

func _on_StaticBody_input_event(camera, event, position, normal, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		emit_signal("show_note")
