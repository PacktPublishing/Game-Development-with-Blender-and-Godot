extends Spatial

export(NodePath) onready var backpack = get_node(backpack) as Node

onready var key_collected:bool = false

func _ready():
	backpack.connect("key_collected", self, "on_key_collected")

func on_key_collected():
	key_collected = true

func _on_Area_body_entered(body):
	if body.name == "Player":
		if key_collected:
			$OpenDoor.play()
		else:
			$LockFiddling.play()
