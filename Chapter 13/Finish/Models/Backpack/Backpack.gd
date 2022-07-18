extends Spatial

signal key_collected

func _on_Area_body_entered(body):
	if body.name == "Player":
		$AudioStreamPlayer.play()
		emit_signal("key_collected")
