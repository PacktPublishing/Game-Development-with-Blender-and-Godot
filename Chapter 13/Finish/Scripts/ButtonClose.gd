extends Button

func _ready():
	connect("pressed", self, "on_pressed")
	
func on_pressed():
	get_parent().visible = false
	get_node("../AudioStreamPlayer").play()
