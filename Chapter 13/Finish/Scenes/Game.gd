extends Node

func _ready():
	EventBus.connect("change_level", self, "change_level")

func change_level(level:String):
	var new_level = load("res://Scenes/" + level).instance()
	
	$Level.remove_child($Level.get_child(0))
	$Level.add_child(new_level)
