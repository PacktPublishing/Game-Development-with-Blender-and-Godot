extends Spatial



func _on_StaticBody_mouse_entered():
	print("yebebo")


func _on_StaticBody_input_event(camera, event, position, normal, shape_idx):
	print("zibar")
