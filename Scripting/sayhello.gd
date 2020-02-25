extends Panel

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _ready():
	get_node("Button").connect("pressed", self, "_on_Button_pressed")

# Nodes are referenced by name, not by type
# If Button is a child of Label
# Then, it would be get_node("Label/Button")
# object.connect

func _on_Button_pressed():
	get_node("Label").text = "HELLO!"
