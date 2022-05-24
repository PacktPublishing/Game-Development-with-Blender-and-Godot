tool
extends Spatial

export(bool) var is_lit = false setget switch

func _ready():
	$OmniLight.visible = is_lit

func switch(condition):
	is_lit = condition
	$OmniLight.visible = condition
