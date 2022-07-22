extends CanvasLayer

export(NodePath) onready var note_trigger = get_node(note_trigger) as Node

func _ready():
	note_trigger.connect("show_note", self, "on_show_note")

func on_show_note():
	$Panel.visible = true
