tool
extends Spatial

export(bool) var is_lit = false setget switch

func switch(condition):
	is_lit = condition

func _process(_delta: float) -> void:
	$OmniLight.visible = is_lit
	
	if is_lit:
		yield(get_tree().create_timer(randf()*2.0),"timeout")
		$AnimationPlayer.play("Flicker")

func _on_Area_body_entered(body):
	if body.name == "Player":		
		if is_lit == false:
			$AudioStreamPlayer.play()
		is_lit = true
