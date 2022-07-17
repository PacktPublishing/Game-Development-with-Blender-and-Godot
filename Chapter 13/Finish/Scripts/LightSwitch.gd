tool
extends Spatial

export(bool) var is_lit = false setget switch

func switch(condition):
	is_lit = condition

func _process(_delta: float) -> void:
	$OmniLight.visible = is_lit

func _on_Area_body_entered(body):
	if body.name == "Player":
		is_lit = true
